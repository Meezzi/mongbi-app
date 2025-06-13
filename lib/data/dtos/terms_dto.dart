import 'package:mongbi_app/domain/entities/terms.dart';

class TermsDto {
  factory TermsDto.fromJson(Map<String, dynamic> json) => TermsDto(
    id: json['TERMS_ID'],
    name: json['TERMS_NAME'],
    requirement: json['TERMS_REQUIREMENT'],
    type: json['TERMS_TYPE'],
    content: json['TERMS_CONTENT'],
  );

  TermsDto({
    required this.id,
    required this.name,
    required this.type,
    required this.requirement,
    required this.content,
  });
  
  final int id;
  final String? name;
  final String type;
  final String requirement;
  final String content;

  Terms toEntity() => Terms(
    id: id,
    name: name ?? '',
    type: type,
    requirement: requirement,
    content: content,
  );
}
