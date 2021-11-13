import 'dart:io';

import 'package:dio/dio.dart';
import 'package:spike_code_interview/core/error/failure.dart';
import 'package:spike_code_interview/data/models/question_response/qr_request.dart';
import 'package:spike_code_interview/data/models/question_response/qr_response.dart';

class RemoteApi {
  static const String url = 'https://opentdb.com/api.php';

  ///get question and answers from API

  Future<List<QuestionResponse>> getQuestions(QuestionRequest request) async {
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results']);
        if (results.isNotEmpty) {
          return results
              .map((questionResponse) =>
                  QuestionResponse.fromMap(questionResponse))
              .toList();
        } else {
          throw const Failure(message: "No data Found");
        }
      } else {
        throw const Failure(message: "Server Error");
      }
    } on DioError catch (err) {
      throw Failure(
          message: err.response?.statusMessage ?? "Something Went Wrong");
    } on SocketException catch (err) {
      throw Failure(message: err.message);
    } on Failure catch (_) {
      rethrow;
    }
  }
}
