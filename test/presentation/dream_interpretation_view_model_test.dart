import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_interpretation_view_model.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

void main() {
  late ProviderContainer container;
  late DreamInterpretationViewModel viewModel;
  late MockDreamRepository mockDreamRepository;

  setUpAll(() {
    registerFallbackValue(FakeDream());
  });

  setUp(() {
    mockDreamRepository = MockDreamRepository();

    container = ProviderContainer(
      overrides: [
        dreamRepositoryProvider.overrideWithValue(mockDreamRepository),
      ],
    );

    viewModel = container.read(dreamInterpretationViewModelProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('DreamInterpretationViewModel saveDream Test', () {
    test('saveDream이 성공하면 true 반환', () async {
      // Arrange
      when(
        () => mockDreamRepository.saveDream(any()),
      ).thenAnswer((_) async => true);

      viewModel.setDream(
        Dream(
          createdAt: DateTime.now(),
          uid: 4,
          challengeId: 0,
          content: '',
          score: 1,
          dreamKeywords: ['테스트'],
          dreamSubTitle: '테스트 해석',
          dreamInterpretation: '테스트 해몽',
          psychologicalSubTitle: '테스트 심리',
          psychologicalStateInterpretation: '심리상태 테스트',
          psychologicalStateKeywords: ['심리'],
          mongbiComment: '몽비 코멘트',
          dreamCategory: '길몽',
        ),
      );

      // Act
      final result = await viewModel.saveDream();

      // Assert
      expect(result, true);
      verify(() => mockDreamRepository.saveDream(any())).called(1);
    });

    test('saveDream이 실패하면 false 반환', () async {
      // Arrange
      when(
        () => mockDreamRepository.saveDream(any()),
      ).thenAnswer((_) async => false);

      viewModel.setDream(
        Dream(
          createdAt: DateTime.now(),
          uid: 4,
          challengeId: 0,
          content: '',
          score: 1,
          dreamKeywords: ['테스트'],
          dreamSubTitle: '테스트 해석',
          dreamInterpretation: '테스트 해몽',
          psychologicalSubTitle: '테스트 심리',
          psychologicalStateInterpretation: '심리상태 테스트',
          psychologicalStateKeywords: ['심리'],
          mongbiComment: '몽비 코멘트',
          dreamCategory: '길몽',
        ),
      );

      // Act
      final result = await viewModel.saveDream();

      // Assert
      expect(result, false);
      verify(() => mockDreamRepository.saveDream(any())).called(1);
    });
  });
}

class MockDreamRepository extends Mock implements DreamRepository {}

class FakeDream extends Fake implements Dream {}
