// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_collection_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginated<TModel> _$PaginatedFromJson<TModel>(Map<String, dynamic> json) {
  return Paginated<TModel>()
    ..data =
        (json['data'] as List)?.map(_Converter<TModel>().fromJson)?.toList()
    ..totalCount = json['totalCount'] as int;
}

Map<String, dynamic> _$PaginatedToJson<TModel>(Paginated<TModel> instance) =>
    <String, dynamic>{
      'data': instance.data?.map(_Converter<TModel>().toJson)?.toList(),
      'totalCount': instance.totalCount,
    };
