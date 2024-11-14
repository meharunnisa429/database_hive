import 'package:database_hive_2/database/functions/db_functions.dart';
import 'package:database_hive_2/database/model/person.dart';
import 'package:database_hive_2/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListPersonWidget extends StatelessWidget {
  final void Function(Person p, int index) callback;
  const ListPersonWidget({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxPerson.listenable(),
      builder: (context, Box<Person> box, _) {
        final values = box.values.toList().cast<Person>();
        return ListView.separated(
          itemBuilder: (context, index) {
            final person = values[index];
            return Card(
              child: ListTile(
                title: Text("Name:- ${person.name}"),
                subtitle: Text("Age:- ${person.age}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // take data to update
                        callback(person, index);
                        
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        deletePerson(index);
                      },
                      color: Colors.red,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: values.length,
        );
      },
    );
  }
}
