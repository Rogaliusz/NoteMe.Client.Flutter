import 'package:json_annotation/json_annotation.dart';
import 'package:noteme/domain/notes/attachments/models/attachment_model.dart';
import 'package:noteme/domain/notes/models/notes_model.dart';

part 'api_collection_response.g.dart';

@JsonSerializable()
class Paginated<TModel> {
  Paginated();

  @_Converter()
  List<TModel> data;
  int totalCount;

  factory Paginated.fromJson(Map<String, dynamic> json) =>
      _$PaginatedFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (T == Note) {
      return Note.fromJson(json) as T;
    }

    if (T == Attachment) {
      return Attachment.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}
