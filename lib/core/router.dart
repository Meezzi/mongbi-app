import 'package:go_router/go_router.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_loading_page.dart';
import 'package:mongbi_app/presentation/dream/dream_analysis_result_page.dart';
import 'package:mongbi_app/presentation/dream/dream_interpretation_page.dart';
import 'package:mongbi_app/presentation/dream/dream_write_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => DreamWritePage()),
    GoRoute(
      path: '/dream_analysis_loading',
      builder: (context, state) => DreamAnalysisLoadingPage(),
    ),
    GoRoute(
      path: '/dream_analysis_result',
      builder: (context, state) => DreamAnalysisResultPage(),
    ),
    GoRoute(
      path: '/dream_interpretation',
      builder: (context, state) => DreamInterpretationPage(),
    ),
  ],
);
