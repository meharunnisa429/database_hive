import 'package:database_hive_2/database/model/person.dart';
import 'package:database_hive_2/main.dart';

// add data
void addPerson(Person person) async {
  await boxPerson.add(person);
}

// Update person
void updatePerson(Person person, int indexToUpdate) async {
  await boxPerson.putAt(indexToUpdate, person);
}

// delete person
void deletePerson(int index) async {
  await boxPerson.delete(index);
}
