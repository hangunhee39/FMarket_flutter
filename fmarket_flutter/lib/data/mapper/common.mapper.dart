import '../dto/common/response_wrapper/response_wrapper.dart';

//<ResponseWrapper<List<MenuDto>>> 에서 MenuDto -> Menu 로 맵핑할 때 responseWrapper 도 매핑 필요
extension ResponseWrapperX on ResponseWrapper{
  ResponseWrapper<T> toModel<T>(T data){
    return ResponseWrapper<T>(
      status: status,
      code: code,
      message: message,
      data: data,
    );
  }
}