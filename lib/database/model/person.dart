import 'package:hive_flutter/hive_flutter.dart';
part 'person.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;

  Person(this.name, this.age);

  Person copyWith({
    String? name,
    int? age,
  }) {
    return Person(
      name ?? this.name,
      age ?? this.age,
    );
  }
}
