import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:noteme/framework/web/api/responses/api_response.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

import 'api_settings.dart';

@injectable
@lazySingleton
class ApiService {
  final ApiSettings settings;
  final http.Client _client = http.Client();
  final Map<String, String> _headers = new Map<String, String>();

  ApiService(this.settings) {
    _headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  setToken(String value) {
    _headers[HttpHeaders.authorizationHeader] = 'Bearer $value';
  }

  Future<ApiResponse> post(String endpoint, dynamic body) async {
    var url = getUrl(endpoint);
    var jsonBody = utf8.encode(json.encode(body));
    var response = await _client.post(url, headers: _headers, body: jsonBody);

    return new ApiResponse(
        json.decode(response.body), response.body, response.statusCode);
  }

  Future<ApiResponse> put(String endpoint, dynamic body) async {
    var url = getUrl(endpoint);
    var jsonBody = utf8.encode(json.encode(body));
    var response = await _client.put(url, body: jsonBody, headers: _headers);

    return new ApiResponse(
        json.decode(response.body), response.body, response.statusCode);
  }

  Future<ApiResponse> get(String endpoint) async {
    var url = getUrl(endpoint);
    var response = await _client.get(url, headers: _headers);

    return new ApiResponse(
        json.decode(response.body), response.body, response.statusCode);
  }

  Future<ApiResponse> delete(String endpoint) async {
    var response = await _client.delete(getUrl(endpoint), headers: _headers);

    return new ApiResponse(
        json.decode(response.body), response.body, response.statusCode);
  }

  Future downloadFile(String endpoint, String path) async {
    var url = getUrl(endpoint);
    var bytes = await _client.readBytes(url, headers: _headers);
    await File(path).writeAsBytes(bytes);
  }

  Future uploadFile(String endpoint, String path, String id) async {
    var file = File(path);
    var isExists = await file.exists();
    if (!isExists) {
      return;
    }

    final url = getUrl(endpoint);
    final uri = Uri.parse(url);
    final ext = extension(path);

    final req = http.MultipartRequest("POST", uri);
    req.files.add(await http.MultipartFile.fromPath(
      "file",
      file.path,
      filename: id + ext,
    ));

    req.headers[HttpHeaders.authorizationHeader] =
        _headers[HttpHeaders.authorizationHeader];

    final response = await req.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  getUrl(String endpoint) {
    return this.settings.address + endpoint;
  }
}
