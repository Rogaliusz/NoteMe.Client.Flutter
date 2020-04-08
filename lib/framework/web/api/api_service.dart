import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:noteme/framework/web/api/responses/api_response.dart';

import 'api_settings.dart';

@injectable
class ApiService {
  final ApiSettings settings;
  final http.Client _client = http.Client();
  final Map<String, String> _headers = new Map<String, String>();

  ApiService(this.settings) {
    _headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  setToken(String value) {
    _headers[HttpHeaders.authorizationHeader] = 'Bearer "$value"';
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
    var response = await _client.get(getUrl(endpoint), headers: _headers);

    return new ApiResponse(
        json.decode(response.body), response.body, response.statusCode);
  }

  Future<ApiResponse> delete(String endpoint) async {
    var response = await _client.delete(getUrl(endpoint), headers: _headers);

    return new ApiResponse(
        json.decode(response.body), response.body, response.statusCode);
  }

  getUrl(String endpoint) {
    return this.settings.address + endpoint;
  }
}
