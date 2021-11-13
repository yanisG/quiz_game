import 'package:equatable/equatable.dart';

enum GameStatus { initial, correct, incorrect, complete }

class GameState extends Equatable {
  final String selectedAnswer;
  final int nbCorrect;
  final GameStatus status;

  const GameState(
      {required this.selectedAnswer,
      required this.nbCorrect,
      required this.status});

  @override
  List<Object?> get props => [selectedAnswer, nbCorrect, status];

  factory GameState.initial() {
    return const GameState(
        nbCorrect: 0, selectedAnswer: '', status: GameStatus.initial);
  }

  bool get answered =>
      status == GameStatus.incorrect || status == GameStatus.correct;

  GameState copyWith({
    String? selectedAnswer,
    int? nbCorrect,
    GameStatus? status,
  }) {
    return GameState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      nbCorrect: nbCorrect ?? this.nbCorrect,
      status: status ?? this.status,
    );
  }
}
