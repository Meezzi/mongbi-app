class AlarmDto {
  AlarmDto({this.type, this.date, this.content});

  final String? type;
  final String? date;
  final String? content;

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
