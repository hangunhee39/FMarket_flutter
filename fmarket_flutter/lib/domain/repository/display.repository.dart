import '../../data/dto/common/response_wrapper/response_wrapper.dart';
import '../../presentation/main/cubit/mall_type_cubit.dart';
import '../model/display/cart/cart.model.dart';
import '../model/display/display.model.dart';
import 'repository.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType({
    required MallType mallType,
  });

  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
    required int page,
  });

  ///장바구니 리스트 불러오기
  Future<ResponseWrapper<List<Cart>>> getCartList();

  ///장바구니 담기
  Future<ResponseWrapper<List<Cart>>> addCartList({required Cart cart});

  ///장바구니 삭제
  Future<ResponseWrapper<List<Cart>>> deleteCartByProductId(
    List<String> productIds,
  );

  ///장바구니 초기화
  Future<ResponseWrapper<List<Cart>>> clearCartList();

  ///장바구니 수량 변경
  Future<ResponseWrapper<List<Cart>>> changeCartQuantityByProductId({
    required String productId,
    required int qty,
  });
}
