import 'dart:convert';
import 'dart:ffi';

import '../../../dto/common/response_wrapper/response_wrapper.dart';
import '../../../dto/display/menu/menu_dto.dart';
import '../../../dto/display/view_module/view_module_dto.dart';
import '../../remote/display.api.dart';
import 'display_mock_data.dart';

class DisplayMockApi implements DisPlayApi {
  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(String mallType) {
    return Future.delayed(
      const Duration(milliseconds: 400),
      () => ResponseWrapper(
        status: 'SUCCESS',
        code: '0000',
        message: '',
        data: _menuParser(
          mallType == 'market'
              ? DisplayMockData.menusByMarket
              : DisplayMockData.menusByBeauty,
        ),
      ),
    );
  }

  @override
  Future<ResponseWrapper<List<ViewModelDto>>> getMenuModuleByTabId(int tabId) {
    late String source;
    final endOfTapId = tabId % 10;
    switch (endOfTapId) {
      case 1:
        source = DisplayMockData.viewModulesByTabIdCaseOne;
      case 2:
        source = DisplayMockData.viewModulesByTabIdCaseTwo;
      case 3:
        source = DisplayMockData.viewModulesByTabIdCaseThree;
      case 4:
        source = DisplayMockData.viewModulesByTabIdCaseFour;
      case 5:
        source = DisplayMockData.viewModulesByTabIdCaseFive;
    }

    return Future(
      () => ResponseWrapper(
        status: 'SUCCESS',
        code: '0000',
        message: '',
        data: _viewModelParser(source),
      ),
    );
  }

  //파싱
  List<MenuDto> _menuParser(String source) {
    List<MenuDto> menus = [];
    final List json = jsonDecode(source);
    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  }

  List<ViewModelDto> _viewModelParser(String source) {
    List<ViewModelDto> viewModules = [];
    final List json = jsonDecode(source);
    viewModules = json.map((e) => ViewModelDto.fromJson(e)).toList();

    return viewModules;
  }
}
