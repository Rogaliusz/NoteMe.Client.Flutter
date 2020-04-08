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
    ..statusSynchronization = _$enumDecodeNullable(
        _$SynchronizationStatusEnumEnumMap, json['statusSynchronization'])
    ..name = json['name'] as String
    ..content = json['content'] as String
    ..tags = json['tags'] as String
    ..status = _$enumDecodeNullable(_$StatusEnumEnumMap, json['status'])
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
      'statusSynchronization':
          _$SynchronizationStatusEnumEnumMap[instance.statusSynchronization],
      'name': instance.name,
      'content': instance.content,
      'tags': instance.tags,
      'status': _$StatusEnumEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SynchronizationStatusEnumEnumMap = {
  SynchronizationStatusEnum.Ok: 'Ok',
  SynchronizationStatusEnum.NeedInsert: 'NeedInsert',
  SynchronizationStatusEnum.NeedUpdate: 'NeedUpdate',
  SynchronizationStatusEnum.NeedDelete: 'NeedDelete',
  SynchronizationStatusEnum.NeedUpload: 'NeedUpload',
};

const _$StatusEnumEnumMap = {
  StatusEnum.Normal: 'Normal',
  StatusEnum.Archived: 'Archived',
  StatusEnum.Historical: 'Historical',
};
