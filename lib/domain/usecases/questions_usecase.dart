import 'dart:math';

import 'package:spike_code_interview/domain/abstractions/question_repository.dart';
import 'package:spike_code_interview/domain/entities/question.dart';

class QuestionsUseCase {
  final QuestionsRepository _repository;

  QuestionsUseCase(this._repository);

  /// making a use case of 5 question game and random category

  Future<List<Question>> getQuestions() {
    return _repository.getQuestions(
        numQuestions: 5, categoryId: Random().nextInt(24) + 9);
  }
}
