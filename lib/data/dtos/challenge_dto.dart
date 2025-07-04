import 'package:mongbi_app/core/remove_html_tags.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';

class ChallengeDto {
  ChallengeDto(
    this.id,
    this.title,
    this.content,
    this.type,
    this.dreamScore,
    this.isComplete,
  );

  final int id;
  final String title;
  final String content;
  final String type;
  final int dreamScore;
  final bool isComplete;

  ChallengeDto.fromJson(Map<String, dynamic> json)
    : id = json['CHALLENGE_ID'] as int,
      title = json['CHALLENGE_NAME'] as String,
      content = removeHtmlTags(json['CHALLENGE_DESC'] as String),
      type = removeHtmlTags(json['CHALLENGE_TYPE'] as String),
      dreamScore = json['CHALLENGE_TRAIT'] as int,
      isComplete = json['IS_COMPLETE'] ?? false;

  Map<String, dynamic> toJson() => {
    'CHALLENGE_ID': id,
    'CHALLENGE_NAME': title,
    'CHALLENGE_DESC': content,
    'CHALLENGE_TYPE': type,
    'CHALLENGE_TRAIT': dreamScore,
    'IS_COMPLETE': isComplete,
  };

  Challenge toEntity() {
    return Challenge(
      id: id,
      content: content,
      type: type,
      dreamScore: dreamScore,
      isComplete: isComplete,
    );
  }
}
