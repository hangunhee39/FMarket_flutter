import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../model/common/result.dart';
import '../../../repository/display.repository.dart';
import '../../base/local.usecase.dart';

class DeleteCartUseCase extends LocalUsecase<DisplayRepository> {
  final List<String> productIds;

  DeleteCartUseCase(this.productIds);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.deleteCartByProductId(productIds);

    return result.status.isSuccess
        ? Result.success(result.data)
        : Result.failure(ErrorResponse(
      message: result.message,
      code: result.code,
      status: result.status,
    ));
  }
}