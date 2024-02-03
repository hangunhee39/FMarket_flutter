import '../../data/dto/common/response_wrapper/response_wrapper.dart';
import '../../presentation/main/cubit/mall_type_cubit.dart';
import '../model/display/display.model.dart';
import 'repository.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType({
    required MallType mallType,
  });

  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
  });
}
