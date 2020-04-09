// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synchronization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Synchronization _$SynchronizationFromJson(Map<String, dynamic> json) {
  return Synchronization(
    id: json['id'] as String,
    lastSynchronization: json['lastSynchronization'] == null
        ? null
        : DateTime.parse(json['lastSynchronization'] as String),
    statusSynchronization: json['statusSynchronization'] as int,
  );
}

Map<String, dynamic> _$SynchronizationToJson(Synchronization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastSynchronization': instance.lastSynchronization?.toIso8601String(),
      'statusSynchronization': instance.statusSynchronization,
    };
