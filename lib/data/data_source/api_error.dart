import 'package:app_studiogenesis/domain/models/exception/failure.dart';

class ApiError extends Failure {
  final int code;

  ApiError.fromJson(int statusCode, Map<String, dynamic> json)
      : code = statusCode,
        super(
            message: json["data"]?["message"] ?? "",
            extensionMessage: json["data"]["error_message"].toString());
}
