import 'package:json_annotation/json_annotation.dart';
import 'package:noteme/framework/synchronizators/synchornization_provider.dart';

part "attachment_model.g.dart";

@JsonSerializable()
class Attachment implements SynchonizationProvider {
  Attachment();

  String name;
  String id;
  DateTime createdAt;
  DateTime lastSynchronization;
  int statusSynchronization;
  String path;
  String noteId;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  get status => null;

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
