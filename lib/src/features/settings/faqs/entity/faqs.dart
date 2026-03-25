import '../../../../config/res/config_imports.dart';
import '../../../../core/base_crud/code/domain/base_domain_imports.dart';

class FaqEntity extends BaseEntity {
  final String question;
  final String answer;

  const FaqEntity({
    required super.id,
    required this.question,
    required this.answer,
  });

  factory FaqEntity.initial() => const FaqEntity(
    id: 0,
    question: SkeltonizerManager.medium,
    answer: SkeltonizerManager.medium,
  );

  factory FaqEntity.fromJson(Map<String, dynamic> json) => FaqEntity(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
  );

  @override
  BaseEntity copyWith({int? id}) =>
      FaqEntity(id: id ?? this.id, question: question, answer: answer);
}
