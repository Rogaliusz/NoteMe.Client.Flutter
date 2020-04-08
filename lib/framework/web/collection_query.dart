import 'dart:convert';

class CollectionQuery {
  CollectionQuery({this.where, this.orderBy});

  String where = "";
  String orderBy = "";

  // String get where => _where;
  // set where(String value) {
  //   _where = value;
  // }

  // String get orderBy => _orderBy;
  // set orderBy(String value) {
  //   _orderBy = value;
  // }

  String _toBase64(String value) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(value);
  }

  int page;
  int pageSize;

  String toUri() {
    StringBuffer stringBuilder = new StringBuffer("?");

    if (this.where != null && this.where.isNotEmpty) {
      stringBuilder.write("Where=" + _toBase64(this.where) + "&");
    }
    if (this.orderBy != null && this.orderBy.isNotEmpty) {
      stringBuilder.write("OrderBy=" + _toBase64(this.orderBy) + "&");
    }
    if (this.page != null && this.page != 0) {
      stringBuilder.write("Page=$page&");
    }
    if (this.pageSize != null && this.pageSize != 0) {
      stringBuilder.write("PageSize=$pageSize&");
    }

    var uri = stringBuilder.toString();
    uri = uri.substring(0, uri.length - 1);

    return uri;
  }
}
