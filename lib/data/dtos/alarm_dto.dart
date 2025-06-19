class AlarmDto {
  const AlarmDto({
    required this.type,
    required this.date,
    required this.content,
  });

  final String type;
  final String date;
  final String content;

  factory AlarmDto.fromJson(Map<String, dynamic> json) => AlarmDto(
    type: json['type'],
    date: json['date'],
    content: json['content'],
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'date': date,
    'content': content,
  };
}
