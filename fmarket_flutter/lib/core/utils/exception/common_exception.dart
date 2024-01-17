import 'package:dio/dio.dart';

import '../error/error_response.dart';

//예외처리

class CommonException {
  const CommonException();

  static ErrorResponse setError(error) {
    if (error is Exception) {
      if (error.runtimeType == DioException) {
        final dioError = error as DioException;
        final code = dioError.response?.statusCode.toString() ?? '9999';

        return ErrorResponse(
          message: '접속하신 네트워크 환경이 불안정합니다. \n 잠시후 다시 시도해주세요.',
          code: code,
          status: 'network error',
        );
      } else {
        final code = '8888';

        return ErrorResponse(
          message: '서비스의 일시적인 오류가 발생했습니다. \n 잠시후 다시 시도해주세요.',
          code: code,
          status: 'unExpected error',
        );
      }
    } else {
      final code = '7777';

      return ErrorResponse(
        message: '서비스의 일시적인 오류가 발생했습니다. \n 잠시후 다시 시도해주세요.',
        code: code,
        status: 'unExpected error',
      );
    }
  }
}
