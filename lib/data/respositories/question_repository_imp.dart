import 'package:spike_code_interview/data/models/question_response/qr_request.dart';
import 'package:spike_code_interview/data/resources/remote/opentdb_api.dart';
import 'package:spike_code_interview/domain/abstractions/question_repository.dart';
import 'package:spike_code_interview/domain/entities/question.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final RemoteApi _remoteApi;

  QuestionsRepositoryImpl(this._remoteApi);

  /// getting questions of type 'multiple'

  @override
  Future<List<Question>> getQuestions(
      {required int numQuestions, required int categoryId}) {
    return _remoteApi
        .getQuestions(QuestionRequest(
            type: 'multiple',
            amount: numQuestions.toString(),
            category: categoryId.toString()))
        .then((questionResponses) {
      return questionResponses.map((e) => e.toEntity()).toList();
    });
  }
}
