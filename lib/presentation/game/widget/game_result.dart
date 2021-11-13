import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spike_code_interview/core/riverpod_providers/providers.dart';
import 'package:spike_code_interview/presentation/common/widgets/custom_button.dart';
import 'package:spike_code_interview/presentation/game/viewmodel/game_state.dart';

class GameResults extends ConsumerWidget {
  final GameState state;
  final int nbQuestions;

  const GameResults({
    required this.state,
    required this.nbQuestions,
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.nbCorrect} / $nbQuestions',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40.0),
        CustomButton(
          title: 'New Quiz',
          onTap: () {
            ref.refresh(questionsProvider);
            ref.read(gameViewModelProvider.notifier).reset();
          },
        )
      ],
    );
  }
}
