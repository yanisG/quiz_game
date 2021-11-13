import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spike_code_interview/domain/entities/question.dart';
import 'package:spike_code_interview/domain/usecases/questions_usecase.dart';

import 'game_state.dart';

class GameViewModel extends StateNotifier<GameState> {
  GameViewModel(this._useCase) : super(GameState.initial());
  final QuestionsUseCase _useCase;

  Future<List<Question>> getQuestions() {
    return _useCase.getQuestions();
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        nbCorrect: state.nbCorrect + 1,
        status: GameStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        status: GameStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
        selectedAnswer: '',
        status: currentIndex + 1 < questions.length
            ? GameStatus.initial
            : GameStatus.complete);
  }

  void reset() {
    state = GameState.initial();
  }
}
