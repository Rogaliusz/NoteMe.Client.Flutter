import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:noteme/domain/common/status_enum.dart';
import 'package:noteme/domain/notes/attachments/attachment_repository.dart';
import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';
import 'package:noteme/framework/synchronizators/models/synchronization_model.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';
import 'package:noteme/framework/web/api/api_endpoints.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/responses/api_collection_response.dart';
import 'package:noteme/framework/web/collection_query.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
@injectable
class AttachmentsSynchronizator
    implements SynchronizationHandlerBase<Attachment> {
  final ApiService _apiService;
  final AttachmentRepository _repository;

  AttachmentsSynchronizator(this._apiService, this._repository);

  @override
  Future<void> syncIt(Synchronization synchronization) async {
    await fetch(synchronization);
    await insert(synchronization);
    await upload(synchronization);
    await download(synchronization);
  }

  Future<void> fetch(Synchronization synchronization) async {
    var syncDate = synchronization.lastSynchronization;
    var hasMore = false;
    var all = new List<Attachment>();

    do {
      var filterBy = "CreatedAt > \"$syncDate\"";
      var orderBy = "CreatedAt-desc";
      var query = new CollectionQuery(orderBy: orderBy, where: filterBy);
      var response = await _apiService.get(AttachmentsEndpoint + query.toUri());

      if (!response.isCorrect) {
        throw new Exception('invalid response: ${response.body}');
      }

      var attachments = Paginated<Attachment>.fromJson(response.json);

      if (attachments.data.length == 0 && all.length == 0) {
        return;
      }

      hasMore = attachments.data.length == query.pageSize;

      for (var attachmentDto in attachments.data) {
        var attachment = await _repository.fetchById(attachmentDto.id);

        if (attachmentDto.status == StatusWrapper.normal) {
          all.add(attachment);
        }

        await _repository.insert(attachment);
      }
    } while (hasMore);
  }

  Future<void> insert(Synchronization synchronization) async {
    final all = await _repository.fetch();
    final toInsert = all
        .where((x) =>
            x.statusSynchronization == SynchronizationStatusWrapper.needInsert)
        .toList();

    for (final item in toInsert) {
      final response =
          await _apiService.post(AttachmentsEndpoint, item.toJson());
      if (response.isCorrect) {
        item.lastSynchronization = DateTime.now().toUtc();
        item.statusSynchronization = SynchronizationStatusWrapper.needUpload;
        await _repository.update(item);
      }
    }
  }

  Future<void> upload(Synchronization synchronization) async {
    var attachmentsToUpload = (await _repository.fetch())
        .where((x) =>
            x.statusSynchronization == SynchronizationStatusWrapper.needUpload)
        .toList();

    for (final attachment in attachmentsToUpload) {
      await _apiService.uploadFile(
          UploadEndpoint, attachment.path, attachment.id);
      attachment.statusSynchronization = SynchronizationStatusWrapper.ok;
      await _repository.update(attachment);
    }
  }

  Future<void> download(Synchronization synchronization) async {
    var attachmentsWithoutPath = await _repository.fetch();

    for (final attachment in attachmentsWithoutPath
        .where((x) => x.path.isEmpty || File(x.path).existsSync())) {
      final directory = await getApplicationDocumentsDirectory();
      var fullFilePath = join(directory.path, attachment.name);

      await _apiService.downloadFile(
          DownloadEndpoint + attachment.id, fullFilePath);

      attachment.path = fullFilePath;
    }
  }
}
