import 'package:hive/hive.dart';
part 'wordModel.g.dart';

@HiveType(typeId: 0)
class MyWord {
  @HiveField(1)
  final String word;

  @HiveField(2)
  final String definition;

  @HiveField(3)
  final bool wordToDef;

  @HiveField(4)
  final bool defToWord;

  MyWord(this.word, this.definition, this.wordToDef, this.defToWord);
}
