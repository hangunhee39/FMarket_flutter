import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/utils/rest_client/rest_client.dart';
import 'local_storage/display.dao.dart';
import 'remote/display.api.dart';

//DI
@module
abstract class DateSourceModule {
  final Dio _dio = RestClient().getDio;

  @singleton
  DisPlayApi get displayApi {
    String baseUrl =
        Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080';

    _dio.options.baseUrl = baseUrl;

    return DisPlayApi(_dio);
  }

  @singleton
  DisplayDao get displayDap => DisplayDao();
}
