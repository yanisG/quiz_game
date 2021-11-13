import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spike_code_interview/data/resources/remote/opentdb_api.dart';
import 'package:spike_code_interview/data/respositories/question_repository_imp.dart';
import 'package:spike_code_interview/domain/abstractions/question_repository.dart';
import 'package:spike_code_interview/domain/entities/question.dart';
import 'package:spike_code_interview/domain/usecases/questions_usecase.dart';
import 'package:spike_code_interview/presentation/game/viewmodel/game_state.dart';
import 'package:spike_code_interview/presentation/game/viewmodel/game_view_model.dart';

/// API providers

final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());

/// repository providers

final questionsRepositoryProvider = Provider<QuestionsRepository>(
    (ref) => QuestionsRepositoryImpl(ref.read(remoteApiProvider)));

/// use case providers

final questionsUseCaseProvider = Provider<QuestionsUseCase>(
    (ref) => QuestionsUseCase(ref.read(questionsRepositoryProvider)));

/// ViewModel Providers

final gameViewModelProvider =
    StateNotifierProvider.autoDispose<GameViewModel, GameState>(
        (ref) => GameViewModel(ref.watch(questionsUseCaseProvider)));

/// list of questions  Providers

final questionsProvider =
    FutureProvider.autoDispose<List<Question>>((ref) async {
  return ref.watch(gameViewModelProvider.notifier).getQuestions();
});
