class Alarm {
  const Alarm({
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
}
