import 'package:injectable/injectable.dart';

import '../../domain/model/display/cart/cart.model.dart';
import '../../domain/model/display/menu.model.dart';
import '../../domain/model/display/view_module/view_module.model.dart';
import '../../domain/repository/display.repository.dart';
import '../../presentation/main/cubit/mall_type_cubit.dart';
import '../data_source/local_storage/display.dao.dart';
import '../data_source/remote/display.api.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../mapper/common.mapper.dart';
import '../mapper/display.mapper.dart';

@Singleton(as: DisplayRepository)
class DisplayRepositoryImpl implements DisplayRepository {
  final DisPlayApi _disPlayApi;
  final DisplayDao _displayDao;

  DisplayRepositoryImpl(this._disPlayApi, this._displayDao);

  @override
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType({
    required MallType mallType,
  }) async {
    final response = await _disPlayApi.getMenusByMallType(mallType.name);

    //<ResponseWrapper<List<MenuDto>>> 에서 MenuDto -> Menu 로 맵핑할 때 responseWrapper 도 매핑 필요
    return response.toModel<List<Menu>>(
      response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
    required int page,
  }) async {
    final response = await _disPlayApi.getMenuModuleByTabId(tabId, page);

    return response.toModel<List<ViewModule>>(
      response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> addCartList({required Cart cart}) async {
    final response = await _displayDao.insertCart(cart.toEntity());

    return response.toModel<List<Cart>>(
      response.data?.map((cartEntity) => cartEntity.toModel()).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> changeCartQuantityByProductId({
    required String productId,
    required int qty,
  }) async {
    final response = await _displayDao.changeCart(productId, qty);

    return response.toModel<List<Cart>>(
      response.data?.map((cartEntity) => cartEntity.toModel()).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> clearCartList() async {
    final response = await _displayDao.clearCarts();

    return response.toModel<List<Cart>>(
      response.data?.map((cartEntity) => cartEntity.toModel()).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> deleteCartByProductId(
    List<String> productIds,
  ) async {
    final response = await _displayDao.deleteCart(productIds);

    return response.toModel<List<Cart>>(
      response.data?.map((cartEntity) => cartEntity.toModel()).toList() ?? [],
    );
  }

  @override
  Future<ResponseWrapper<List<Cart>>> getCartList() async {
    final response = await _displayDao.getCartList();

    return response.toModel<List<Cart>>(
      response.data?.map((cartEntity) => cartEntity.toModel()).toList() ?? [],
    );
  }
}
