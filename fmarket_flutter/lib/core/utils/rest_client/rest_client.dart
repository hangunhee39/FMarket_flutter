
import 'package:dio/dio.dart';

//SingleToon
class RestClient {
  final Dio _dio = Dio();

  static final RestClient _instance = RestClient._internal();

  Dio get getDio => _dio;

  factory RestClient() => _instance;

  RestClient._internal();
}