import 'dart:convert';

import 'package:app_studiogenesis/data/data_source/api_error.dart';
import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/environment.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<Either<Failure, Map<String, dynamic>>> get(String path) async {
    _verifyPathFormat(path);
    final url = "${Environment.ngrokApiHostUrl}$path";

    debugPrint(url);

    final res = await http.get(Uri.parse(url), headers: await _buildHeaders());

    debugPrint(
        "StatusCode: ${res.statusCode}, body: ${res.body.length > 3650 ? res.body.substring(0, 3650) : res.body}");

    if (res.statusCode == 200) {
      try {
        return Right(_parseResponse(res.body));
      } catch ($e) {
        return Left(Failure(message: $e.toString()));
      }
    }

    debugPrint("${res.statusCode} message: ${res.body}");
    return Left(_parseError(res.statusCode, res.body));
  }

  Future<Either<Failure, Map<String, dynamic>>> post(
      String path, Object data) async {
    _verifyPathFormat(path);
    final url = "${Environment.ngrokApiHostUrl}$path";
    debugPrint(url);

    final res = await http.post(Uri.parse(url),
        headers: await _buildHeaders(), body: jsonEncode(data));

    debugPrint("StatusCode: ${res.statusCode}, body: ${res.body}");

    if (res.statusCode == 200) {
      try {
        return Right(_parseResponse(res.body));
      } catch ($e) {
        return Left(Failure(message: $e.toString()));
      }
    }
    debugPrint("${res.statusCode} message: ${res.body}");
    return Left(_parseError(res.statusCode, res.body));
  }

  Future<Either<Failure, Map<String, dynamic>>> delete(
      String path, Object data) async {
    _verifyPathFormat(path);
    final url = "${Environment.ngrokApiHostUrl}$path";
    debugPrint(url);

    final res = await http.delete(Uri.parse(url),
        headers: await _buildHeaders(), body: jsonEncode(data));

    debugPrint("StatusCode: ${res.statusCode}, body: ${res.body}");

    if (res.statusCode == 200) {
      try {
        return Right(_parseResponse(res.body));
      } catch ($e) {
        return Left(Failure(message: $e.toString()));
      }
    }
    debugPrint("${res.statusCode} message: ${res.body}");
    return Left(_parseError(res.statusCode, res.body));
  }

  Future<Either<Failure, Map<String, dynamic>>> multiPart(String path,
      {required Map<String, String> data,
      required List<String> filesPath,
      required String typeOfFile}) async {
    _verifyPathFormat(path);
    final url = "${Environment.ngrokApiHostUrl}$path";
    debugPrint(url);

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(data);

    request.headers.addAll(await _buildHeaders(isMultipartRequest: true));

    for (final filePath in filesPath) {
      final file = await http.MultipartFile.fromPath(typeOfFile, filePath);
      request.files.add(file);
    }

    final res = await request.send();

    final responseData = await res.stream.bytesToString();
    debugPrint("StatusCode: ${res.statusCode}, body: $responseData");

    if (res.statusCode == 200) {
      try {
        return Right(_parseResponse(responseData));
      } catch ($e) {
        return Left(Failure(message: $e.toString()));
      }
    }
    debugPrint("${res.statusCode} message: $responseData");
    return Left(_parseError(res.statusCode, responseData));
  }

  Map<String, dynamic> _parseResponse(String body) {
    if (body.isNotEmpty) {
      Map<String, dynamic> response = jsonDecode(body);
      return response["data"];
    } else {
      throw Exception("");
    }
  }

  Future<Map<String, String>> _buildHeaders(
      {bool isMultipartRequest = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    final Map<String, String> map = {
      "Content-Type": isMultipartRequest
          ? "application/json; boundary=----WebKitFormBoundaryyEmKNDsBKjB7QEqu"
          : "application/json",
      "Host": Environment.ngrokHost
    };

    if (token.isNotEmpty) {
      debugPrint("Token: $token");
      map["Authorization"] = "Bearer $token";
    }

    return map;
  }

  _verifyPathFormat(String path) {
    if (path.startsWith("/")) {
      throw ArgumentError("Path can't start with slash /");
    }
  }

  ApiError _parseError(int responseCode, String body) {
    try {
      final map = jsonDecode(body);

      final error = ApiError.fromJson(responseCode, map);
      return error;
    } catch ($e) {
      final error = ApiError.fromJson(responseCode, {
        "data": {"message": "Error intern", "error_message": $e.toString()}
      });
      return error;
    }
  }
}
