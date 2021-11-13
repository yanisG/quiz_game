import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spike_code_interview/core/riverpod_providers/providers.dart';
import 'package:spike_code_interview/domain/entities/question.dart';
import 'package:spike_code_interview/presentation/common/widgets/custom_button.dart';
import 'package:spike_code_interview/presentation/common/widgets/error.dart';
import 'package:spike_code_interview/presentation/game/viewmodel/game_state.dart';
import 'package:spike_code_interview/presentation/game/widget/game_question.dart';
import 'package:spike_code_interview/presentation/game/widget/game_result.dart';

class GameScreen extends HookConsumerWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final viewModelState = ref.watch(gameViewModelProvider);
    final questionsFuture = ref.watch(questionsProvider);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF22293E),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: questionsFuture.map(
            data: (questions) {
              return _buildBody(context, viewModelState, pageController,
                  questions.value, ref);
            },
            loading: (_) => const Center(child: CircularProgressIndicator()),
            error: (error) {
              return Error(
                message: error.error.toString(),
                callback: () => refreshAll(ref),
              );
            }),
        bottomSheet: questionsFuture.maybeWhen(
            data: (questions) {
              if (!viewModelState.answered) return const SizedBox.shrink();
              var currentIndex = pageController.page?.toInt() ?? 0;
              return CustomButton(
                  title: currentIndex + 1 < questions.length
                      ? 'Next Question'
                      : 'See results',
                  onTap: () {
                    ref
                        .read(gameViewModelProvider.notifier)
                        .nextQuestion(questions, currentIndex);
                    if (currentIndex + 1 < questions.length) {
                      pageController.nextPage(
                          duration: const Duration(microseconds: 250),
                          curve: Curves.linear);
                    }
                  });
            },
            orElse: () => const SizedBox.shrink()),
      ),
    );
  }

  void refreshAll(WidgetRef ref) {
    ref.refresh(questionsProvider);
    ref.read(gameViewModelProvider.notifier).reset();
  }

  Widget _buildBody(BuildContext context, GameState state,
      PageController pageController, List<Question> questions, WidgetRef ref) {
    if (questions.isEmpty) {
      return Error(
          message: 'No questions found', callback: () => refreshAll(ref));
    }

    return state.status == GameStatus.complete
        ? GameResults(state: state, nbQuestions: questions.length)
        : GameQuestions(
            pageController: pageController, state: state, questions: questions);
  }
}
