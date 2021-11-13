import 'package:equatable/equatable.dart';

class QuestionRequest extends Equatable {
  final String type;
  final String amount;
  final String category;

  const QuestionRequest({
    required this.type,
    required this.amount,
    required this.category,
  });

  @override
  List<Object?> get props => [category, amount, type];

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'type': type,
      'amount': amount,
    };
  }
}
