import 'package:dio/dio.dart';

class RemoteDreamAnalysisDataSourceImpl {
  RemoteDreamAnalysisDataSourceImpl({
    required this.dio,
    required this.apiKey,
    required this.baseUrl,
  });

  final Dio dio;
  final String apiKey;
  final String baseUrl;
}
