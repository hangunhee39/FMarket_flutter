import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/common/response_wrapper/response_wrapper.dart';
import '../../dto/display/display.dto.dart';

part 'display.api.g.dart';

@RestApi()
abstract class DisPlayApi {
  factory DisPlayApi(Dio dio) = _DisPlayApi;

  @GET('/api/menus/{mall_type}')
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(
    @Path('mall_type') String mallType,
  );

  @GET('/api/view-modules/{tab_id}/{page}')
  Future<ResponseWrapper<List<ViewModelDto>>> getMenuModuleByTabId(
    @Path('tab_id') int tabId,
    @Path("page") int page,
  );
}
