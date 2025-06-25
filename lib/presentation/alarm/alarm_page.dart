import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_app_bar.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_body.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: AlarmAppBar(),
      ),
      body: AlarmBody(),
    );
  }
}
