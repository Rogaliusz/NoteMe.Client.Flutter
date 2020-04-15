// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) {
  return Attachment()
    ..name = json['name'] as String
    ..id = json['id'] as String
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..lastSynchronization = json['lastSynchronization'] == null
        ? null
        : DateTime.parse(json['lastSynchronization'] as String)
    ..statusSynchronization = json['statusSynchronization'] as int
    ..path = json['path'] as String
    ..noteId = json['noteId'] as String;
}

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastSynchronization': instance.lastSynchronization?.toIso8601String(),
      'statusSynchronization': instance.statusSynchronization,
      'path': instance.path,
      'noteId': instance.noteId,
    };
