import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:spike_code_interview/core/riverpod_providers/providers.dart';
import 'package:spike_code_interview/domain/entities/question.dart';
import 'package:spike_code_interview/presentation/game/viewmodel/game_state.dart';

import 'answer_card.dart';

class GameQuestions extends ConsumerWidget {
  final PageController pageController;
  final GameState state;
  final List<Question> questions;

  const GameQuestions({
    required this.pageController,
    required this.state,
    required this.questions,
  }) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: Color(0xff2E415A),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Text(HtmlCharacterEntities.decode(question.category),
                      style: GoogleFonts.notoSans(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.only(right: 19.0, bottom: 5.0),
                      child: Text('${index + 1}/${questions.length}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: LinearProgressIndicator(
                  value: index / questions.length,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xffE6812F)),
                  backgroundColor: Colors.white,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    HtmlCharacterEntities.decode(question.question),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Expanded(
                  child: GridView.builder(
                itemCount: question.answers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4),
                itemBuilder: (BuildContext context, int index) {
                  final answer = question.answers[index];
                  return AnswerCard(
                      answer: answer,
                      isSelected: answer == state.selectedAnswer,
                      isCorrect: answer == question.correctAnswer,
                      isDisplayingAnswer: state.answered,
                      onTap: () => ref
                          .read(gameViewModelProvider.notifier)
                          .submitAnswer(question, answer));
                },
              ))
            ],
          );
        });
  }
}
