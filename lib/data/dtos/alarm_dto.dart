class AlarmDto {
  const AlarmDto({
    required this.id,
    required this.type,
    required this.date,
    required this.content,
    required this.isConfirm,
  });

  final int id;
  final String type;
  final DateTime date;
  final String content;
  final bool isConfirm;

  factory AlarmDto.fromJson(Map<String, dynamic> json) => AlarmDto(
    id: json['ID'], // 'remind' | 'challenge | 'report'
    type: json['TYPE'],
    date: json['DATE'],
    content: json['CONTENT'],
    isConfirm: json['IS_CONFIRM'],
  );

  Map<String, dynamic> toJson() => {
    'ID': id,
    'TYPE': type,
    'DATE': date,
    'CONTENT': content,
    'IS_CONFIRM': isConfirm,
  };
}
