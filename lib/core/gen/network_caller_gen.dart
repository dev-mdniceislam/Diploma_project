import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkCaller {
  // Common Headers
  Map<String, String> _defaultHeaders(Map<String, String>? headers) {
    return {"Content-Type": "application/json", ...?headers};
  }

  // GET Method
  Future<T?> get<T>({
    required String url,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _defaultHeaders(headers),
      );
      return _processResponse<T>(response, fromJson);
    } catch (error) {
      log("============== API Error GET: $error ==============");
      return null;
    }
  }

  // POST Method
  Future<T?> post<T>({
    required String url,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: _defaultHeaders(headers),
      );
      return _processResponse<T>(response, fromJson);
    } catch (error) {
      log("============== API Error POST: $error ==============");
      return null;
    }
  }

  // PUT Method
  Future<T?> put<T>({
    required String url,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: _defaultHeaders(headers),
      );
      return _processResponse<T>(response, fromJson);
    } catch (error) {
      log("============== API Error PUT: $error ==============");
      return null;
    }
  }

  // PATCH Method
  Future<T?> patch<T>({
    required String url,
    required Map<String, dynamic> body,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: _defaultHeaders(headers),
      );
      return _processResponse<T>(response, fromJson);
    } catch (error) {
      log("============== API Error PATCH: $error ==============");
      return null;
    }
  }

  // DELETE Method
  Future<T?> delete<T>({
    required String url,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _defaultHeaders(headers),
      );
      return _processResponse<T>(response, fromJson);
    } catch (error) {
      log("============== API Error DELETE: $error ==============");
      return null;
    }
  }

  // Generic Logic for Processing Response
  T? _processResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    log("API Status Code: ${response.statusCode}");

    if (response.body.isEmpty) return null;

    try {
      final decodedData = jsonDecode(response.body);

      if (fromJson != null && decodedData is Map<String, dynamic>) {
        return fromJson(decodedData);
      }
      return decodedData as T?;
    } catch (e) {
      log("JSON parse error | Status: ${response.statusCode} | $e");
      return null;
    }
  }
}
