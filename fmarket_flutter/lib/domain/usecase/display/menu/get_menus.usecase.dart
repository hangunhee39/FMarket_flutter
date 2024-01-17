import '../../../../core/utils/error/error_response.dart';
import '../../../../presentation/main/cubit/mall_type_cubit.dart';
import '../../../model/common/result.dart';
import '../../../repository/display.repository.dart';
import '../../base/remote.usecase.dart';

class GetMenuUsecase extends RemoteUsecase<DisplayRepository> {
  final MallType mallType;

  GetMenuUsecase(this.mallType);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.getMenuByMallType(mallType: mallType);

    return (result.status == 'SUCCESS')
        ? Result.Success(result ?? [])
        : Result.failure(ErrorResponse(
            message: result.message,
            code: result.code,
            status: result.status,
          ));
  }
}
