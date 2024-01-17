import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_wrapper.freezed.dart';
part 'response_wrapper.g.dart';

//http restFul 규칙
//fromJsonT 사용해야 데이터 타입 제네릭하게 사용
@Freezed(genericArgumentFactories: true)
class ResponseWrapper<T> with _$ResponseWrapper<T> {
  const factory ResponseWrapper({
    @Default('')String status,
    @Default('')String code,
    @Default('')String message,
    T? data,
  }) = _ResponseWrapper;


  //새로운 인스턴스를 생성하지 않는 생성자
  factory ResponseWrapper.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) =>
      _$ResponseWrapperFromJson(json, fromJsonT);
}