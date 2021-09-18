import 'package:json_annotation/json_annotation.dart';


part 'word.g.dart';

@JsonSerializable()
class Word{

  Word(this.base, this.pastSimple, this.pastPaticiple);

  @JsonKey(name: 'Base')
  String base;

  @JsonKey(name: 'Past-simple')
  String pastSimple;

  @JsonKey(name: 'Past-Participle')
  String pastPaticiple;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  Map<String, dynamic> toJson() => _$WordToJson(this);
}