import 'package:json_annotation/json_annotation.dart';
import 'package:noteme/domain/common/status_enum.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';

part 'notes_model.g.dart';

@JsonSerializable()
class Note implements SynchonizationProvider {
  Note();

  @override
  String id;
  @override
  DateTime lastSynchronization;
  @override
  int statusSynchronization;

  String name;
  String content;
  String tags;
  int status;

  DateTime createdAt;
  DateTime modifiedAt;

  double latitude;
  double longitude;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
