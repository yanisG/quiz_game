import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spike_code_interview/data/resources/remote/opentdb_api.dart';
import 'package:spike_code_interview/data/respositories/question_repository_imp.dart';
import 'package:spike_code_interview/domain/abstractions/question_repository.dart';
import 'package:spike_code_interview/domain/usecases/questions_usecase.dart';

/// API providers

final remoteApiProvider = Provider<RemoteApi>((ref) => RemoteApi());

/// DATA providers

final questionsRepositoryProvider = Provider<QuestionsRepository>(
    (ref) => QuestionsRepositoryImpl(ref.read(remoteApiProvider)));

/// DOMAIN providers

final questionsUseCaseProvider = Provider<QuestionsUseCase>(
    (ref) => QuestionsUseCase(ref.read(questionsRepositoryProvider)));
