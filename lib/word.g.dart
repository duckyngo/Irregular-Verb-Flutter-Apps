// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      json['Base'] as String,
      json['Past-simple'] as String,
      json['Past-Participle'] as String,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'Base': instance.base,
      'Past-simple': instance.pastSimple,
      'Past-Participle': instance.pastPaticiple,
    };
