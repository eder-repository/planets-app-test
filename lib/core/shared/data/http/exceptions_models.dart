import 'package:planets_app_test/core/helpers/typedefs.dart';

class BadRequestErrorInfo {
  const BadRequestErrorInfo({required this.code, required this.message});
  factory BadRequestErrorInfo.fromJson(Json json) {
    return BadRequestErrorInfo(
      code: json['Code'] as String? ?? 'UNKNOWN',
      message: json['Message'] as String? ?? 'Bad request',
    );
  }
  final String code;
  final String message;
}
