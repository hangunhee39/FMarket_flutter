import '../../../../core/utils/error/error_response.dart';
import '../../../model/common/result.dart';
import '../../../model/display/view_module/view_module.model.dart';
import '../../../repository/display.repository.dart';
import '../../base/remote.usecase.dart';

class GetViewModulesUsecase extends RemoteUsecase<DisplayRepository> {
  final int tabId;

  GetViewModulesUsecase({required this.tabId});

  @override
  Future<Result<List<ViewModule>>> call(DisplayRepository repository) async {
    final result = await repository.getViewModuleByTabId(tabId: tabId);

    return (result.status == 'SUCCESS')
        ? Result.success(result.data ?? [])
        : Result.failure(
            ErrorResponse(
              message: result.message,
              code: result.code,
              status: result.status,
            ),
          );
  }
}
