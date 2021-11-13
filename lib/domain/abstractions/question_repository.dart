import 'package:spike_code_interview/domain/entities/question.dart';

abstract class QuestionsRepository {
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId});
}
