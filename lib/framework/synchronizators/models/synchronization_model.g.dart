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
    statusSynchronization: _$enumDecodeNullable(
        _$SynchronizationStatusEnumEnumMap, json['statusSynchronization']),
  );
}

Map<String, dynamic> _$SynchronizationToJson(Synchronization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastSynchronization': instance.lastSynchronization?.toIso8601String(),
      'statusSynchronization':
          _$SynchronizationStatusEnumEnumMap[instance.statusSynchronization],
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
