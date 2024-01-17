import 'package:fmarket_flutter/data/data_source/mock/display/display_mock_api.dart';
import 'package:fmarket_flutter/data/data_source/remote/display.api.dart';
import 'package:fmarket_flutter/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:fmarket_flutter/data/dto/display/menu/menu_dto.dart';
import 'package:fmarket_flutter/data/mapper/common.mapper.dart';
import 'package:fmarket_flutter/data/mapper/display.mapper.dart';
import 'package:fmarket_flutter/data/repository_impl/display.repository_impl.dart';
import 'package:fmarket_flutter/domain/model/display/menu.model.dart';
import 'package:fmarket_flutter/domain/repository/display.repository.dart';
import 'package:fmarket_flutter/presentation/main/cubit/mall_type_cubit.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';

class MockDisplayApi extends Mock implements DisPlayApi {}

void main() {
  late DisplayRepository displayRepository;
  late DisPlayApi displayApi;

  //모든 테스테에 사용하겠단 뜻
  setUpAll(() {
    displayApi = MockDisplayApi();
    displayRepository = DisplayRepositoryImpl(displayApi);
  });

  test("의존성 주입 및 객체 생성 완료", () => expect(displayRepository, isNotNull));

  group("메뉴 리스트 불러오기", () {
    //api 코드 호출 성공
    test("api 호출 완료", () async {
      try {
        await displayRepository.getMenuByMallType(mallType: MallType.market);
      } catch (_) {}
      //몇번 호출하는지 체크 기능 : verify
      verify(() => displayApi.getMenusByMallType(any())).called(1);
    });

    test("api 실패", () async {
      final exception = Exception('error');
      when(() => displayApi.getMenusByMallType(any())).thenThrow(exception);
      expect(
          () => displayRepository.getMenuByMallType(mallType: MallType.market),
          throwsA(exception));
    });

    test('api 성공', () async {
      final mallType = MallType.market;

      final ResponseWrapper<List<MenuDto>> mockingApiData = await DisplayMockApi().getMenusByMallType(mallType.name);

      //어떤 동작을 할건지 지정
      when(() => displayApi.getMenusByMallType(mallType.name)).thenAnswer((_) async => mockingApiData);

      final actual = await displayRepository.getMenuByMallType(mallType: mallType);

      final expected = mockingApiData.toModel<List<Menu>>(mockingApiData.data?.map((e) => e.toModel()).toList() ?? []);
      expect(actual, expected);
    });
  });
}
