import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/data/data_sources/dream_data_source.dart';
import 'package:mongbi_app/data/dtos/dream_dto.dart';

void main() {
  DreamDataSource? dreamDataSource;
  RemoteDreamRepository? remoteDreamRepository;

  group('Dream Repository SaveDream Test', () {
    setUp(() {
      dreamDataSource = MockDreamDataSource();
      remoteDreamRepository = RemoteDreamRepository(dreamDataSource);
    });

    test('Return true if dream creation is successful', () async {});
  });
}

class MockDreamDataSource extends Mock implements DreamDataSource {}
