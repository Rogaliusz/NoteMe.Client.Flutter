import 'package:injectable/injectable.dart';
import 'package:noteme/domain/common/status_enum.dart';
import 'package:noteme/domain/notes/notes_repository.dart';
import 'package:noteme/framework/synchronizators/models/synchronization_model.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';
import 'package:noteme/framework/synchronizators/synchronization.dart';
import 'package:noteme/framework/web/api/api_endpoints.dart';
import 'package:noteme/framework/web/api/api_service.dart';
import 'package:noteme/framework/web/api/responses/api_collection_response.dart';
import 'package:noteme/framework/web/collection_query.dart';

import 'models/notes_model.dart';

@lazySingleton
@injectable
class NotesSynchronizator implements SynchronizationHandlerBase<Note> {
  final ApiService _apiService;
  final NoteRepository _noteRepository;

  NotesSynchronizator(this._apiService, this._noteRepository);

  @override
  Future<void> syncIt(Synchronization synchronization) async {
    var syncDate = synchronization.lastSynchronization;
    var hasMore = false;
    var allNotes = new List<Note>();

    do {
      var filterBy = "CreatedAt > \"$syncDate\"";
      var orderBy = "CreatedAt-desc";
      var query = new CollectionQuery(orderBy: orderBy, where: filterBy);
      var response = await _apiService.get(NotesEndpoint + query.toUri());

      if (!response.isCorrect) {
        throw new Exception('invalid response: ${response.body}');
      }

      var notes = Paginated<Note>.fromJson(response.json);

      if (notes.data.length == 0 && allNotes.length == 0) {
        return;
      }

      hasMore = notes.data.length == query.pageSize;

      for (var noteDto in notes.data) {
        var note = await _noteRepository.fetchById(noteDto.id);

        if (note != null) continue;

        if (noteDto.status == StatusWrapper.normal) {
          allNotes.add(note);
        }

        await _noteRepository.insert(noteDto);
      }
    } while (hasMore);
  }
}
