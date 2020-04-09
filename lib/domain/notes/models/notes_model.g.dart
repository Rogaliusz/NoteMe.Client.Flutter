// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note()
    ..id = json['id'] as String
    ..lastSynchronization = json['lastSynchronization'] == null
        ? null
        : DateTime.parse(json['lastSynchronization'] as String)
    ..statusSynchronization = json['statusSynchronization'] as int
    ..name = json['name'] as String
    ..content = json['content'] as String
    ..tags = json['tags'] as String
    ..status = json['status'] as int
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..modifiedAt = json['modifiedAt'] == null
        ? null
        : DateTime.parse(json['modifiedAt'] as String)
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble();
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'lastSynchronization': instance.lastSynchronization?.toIso8601String(),
      'statusSynchronization': instance.statusSynchronization,
      'name': instance.name,
      'content': instance.content,
      'tags': instance.tags,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
