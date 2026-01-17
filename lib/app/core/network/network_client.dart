import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:group_app/app/core/network/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkClient {
  final Logger _logger = Logger();
  final Map<String, String> Function() commonHeaders;
  final VoidCallback onUnAuthorize;
  final String _defaultMessage = 'Something went wrong';
  final Duration _timeoutDuration = Duration(seconds: 30);

  NetworkClient({required this.onUnAuthorize, required this.commonHeaders});

  // ==================== GET REQUEST ====================
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: commonHeaders());
      
      final response = await http.get(
        uri,
        headers: commonHeaders(),
      ).timeout(_timeoutDuration);
      
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // ==================== POST REQUEST ====================
  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: commonHeaders(), body: body);
      
      final response = await http.post(
        uri,
        headers: _getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      ).timeout(_timeoutDuration);
      
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // ==================== PUT REQUEST ====================
  Future<NetworkResponse> putRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: commonHeaders(), body: body);
      
      final response = await http.put(
        uri,
        headers: _getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      ).timeout(_timeoutDuration);
      
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // ==================== PATCH REQUEST ====================
  Future<NetworkResponse> patchRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: commonHeaders(), body: body);
      
      final response = await http.patch(
        uri,
        headers: _getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      ).timeout(_timeoutDuration);
      
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // ==================== DELETE REQUEST ====================
  Future<NetworkResponse> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, headers: commonHeaders());
      
      final response = await http.delete(
        uri,
        headers: commonHeaders(),
      ).timeout(_timeoutDuration);
      
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // ==================== MULTIPART REQUEST (FILE UPLOAD) ====================
  Future<NetworkResponse> multipartRequest(
    String url, {
    required Map<String, String> fields,
    required Map<String, http.MultipartFile> files,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);
      
      // Add headers
      request.headers.addAll(commonHeaders());
      
      // Add fields
      fields.forEach((key, value) {
        request.fields[key] = value;
      });
      
      // Add files
      files.forEach((key, file) {
        request.files.add(file);
      });
      
      _logMultipartRequest(url, fields: fields, files: files.keys.toList());
      
      final streamedResponse = await request.send().timeout(_timeoutDuration);
      final response = await http.Response.fromStream(streamedResponse);
      
      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // ==================== RESPONSE HANDLER ====================
  NetworkResponse _handleResponse(http.Response response) {
    try {
      dynamic responseBody;
      
      // Try to decode JSON
      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        responseBody = response.body;
      }
      
      // Check status code
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: responseBody,
        );
      } else if (response.statusCode == 401) {
        // Unauthorized - trigger logout
        onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Session expired. Please login again.',
        );
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        // Client error
        String errorMessage = _extractErrorMessage(responseBody);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessage,
        );
      } else {
        // Server error
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Server error. Please try again later.',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: _defaultMessage,
      );
    }
  }

  // ==================== EXTRACT ERROR MESSAGE ====================
  String _extractErrorMessage(dynamic responseBody) {
    if (responseBody is Map) {
      return responseBody['message'] ?? 
             responseBody['error'] ?? 
             responseBody['msg'] ?? 
             _defaultMessage;
    } else if (responseBody is String) {
      return responseBody;
    }
    return _defaultMessage;
  }

  // ==================== EXCEPTION HANDLER ====================
  NetworkResponse _handleException(dynamic e) {
    _logger.e('Network Error: $e');
    
    if (e is http.ClientException) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Network error. Check your connection.',
      );
    } else if (e is FormatException) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Invalid response from server.',
      );
    } else if (e is TimeoutException) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: 'Request timeout. Please try again.',
      );
    } else {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: _defaultMessage,
      );
    }
  }

  // ==================== HEADERS HELPER ====================
  Map<String, String> _getHeaders() {
    final headers = commonHeaders();
    headers['Content-Type'] = 'application/json';
    return headers;
  }

  // ==================== LOGGING ====================
  void _logRequest(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    _logger.i('''
    📤 REQUEST
    URL: $url
    METHOD: ${body != null ? 'POST' : 'GET'}
    HEADERS: $headers
    BODY: $body
    ''');
  }

  void _logMultipartRequest(
    String url, {
    required Map<String, String> fields,
    required List<String> files,
  }) {
    _logger.i('''
    📤 MULTIPART REQUEST
    URL: $url
    FIELDS: $fields
    FILES: $files
    ''');
  }

  void _logResponse(http.Response response) {
    _logger.i('''
    📥 RESPONSE
    URL: ${response.request?.url}
    STATUS: ${response.statusCode}
    BODY: ${response.body.length > 500 ? '${response.body.substring(0, 500)}...' : response.body}
    ''');
  }
}