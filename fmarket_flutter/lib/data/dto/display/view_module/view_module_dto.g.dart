// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_module_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViewModelDtoImpl _$$ViewModelDtoImplFromJson(Map<String, dynamic> json) =>
    _$ViewModelDtoImpl(
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$$ViewModelDtoImplToJson(_$ViewModelDtoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
    };
