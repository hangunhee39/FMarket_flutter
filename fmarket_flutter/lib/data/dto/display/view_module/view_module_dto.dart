
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../product_info/product_info.dto.dart';

part 'view_module_dto.freezed.dart';
part 'view_module_dto.g.dart';

@freezed
class ViewModelDto with _$ViewModelDto {
  const factory ViewModelDto({
    @Default('') String? type,
    @Default('') String? title,
    @Default('') String? subtitle,
    @Default('') String? imageUrl,
    @Default(-1) int? time,
    @Default(<ProductInfoDto>[]) List<ProductInfoDto>? products,
    @Default([]) List<String>? tabs,
  }) = _ViewModelDto;

  factory ViewModelDto.fromJson(Map<String, dynamic> json) =>
      _$ViewModelDtoFromJson(json);
}
