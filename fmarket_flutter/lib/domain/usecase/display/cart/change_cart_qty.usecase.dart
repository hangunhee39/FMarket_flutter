import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../model/common/result.dart';
import '../../../repository/display.repository.dart';
import '../../base/local.usecase.dart';

class ChangeCartQtyUsecase extends LocalUsecase<DisplayRepository> {
  final String productId;
  final int qty;

  ChangeCartQtyUsecase(this.productId, this.qty);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.changeCartQuantityByProductId(productId: productId, qty: qty);

    return result.status.isSuccess
        ? Result.success(result.data)
        : Result.failure(ErrorResponse(
      message: result.message,
      code: result.code,
      status: result.status,
    ));
  }
}