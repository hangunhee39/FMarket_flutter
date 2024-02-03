
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_module_dto.freezed.dart';
part 'view_module_dto.g.dart';

@freezed
class ViewModelDto with _$ViewModelDto {
  const factory ViewModelDto({
    @Default('') String type,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String imageUrl,
  }) = _ViewModelDto;



  factory ViewModelDto.fromJson(Map<String, dynamic> json) =>
      _$ViewModelDtoFromJson(json);
}
