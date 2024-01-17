import '../../domain/model/display/menu.model.dart';
import '../../domain/repository/display.repository.dart';
import '../../presentation/main/cubit/mall_type_cubit.dart';
import '../data_source/remote/display.api.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../mapper/common.mapper.dart';
import '../mapper/display.mapper.dart';

class DisplayRepositoryImpl implements DisplayRepository{
  final DisPlayApi _disPlayApi;

  DisplayRepositoryImpl(this._disPlayApi);

  @override
  Future<ResponseWrapper<List<Menu>>> getMenuByMallType({required MallType mallType})async {
    final response = await _disPlayApi.getMenusByMallType(mallType.name);

    //<ResponseWrapper<List<MenuDto>>> 에서 MenuDto -> Menu 로 맵핑할 때 responseWrapper 도 매핑 필요
    return response.toModel<List<Menu>>(
        response.data?.map((e)=>e.toModel()).toList() ?? [],
    );
  }

}