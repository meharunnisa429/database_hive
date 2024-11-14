import 'package:database_hive_2/database/model/person.dart';
import 'package:database_hive_2/main.dart';
import 'package:database_hive_2/screens/widget/add_person_widget.dart';
import 'package:database_hive_2/screens/widget/list_person_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

SaveButtonMode saveButtonMode = SaveButtonMode.save;
int? indexToUpdate;

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _ageFocus;
  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _nameFocusNode = FocusNode();
    _ageFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() async {
    _nameController.dispose();
    _ageController.dispose();
    _nameFocusNode.dispose();
    _ageFocus.dispose();
    await boxPerson.close();

    super.dispose();
  }

  void bringPersonToUpdate(Person person, int index) async {
    _nameController.text = person.name;
    _ageController.text = person.age.toString();
    indexToUpdate = index;
    saveButtonMode = SaveButtonMode.edit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Hive"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AddPersonWidget(
                nameController: _nameController,
                ageController: _ageController,
                nameFocusNode: _nameFocusNode,
                ageFocusNode: _ageFocus,
              ),
              // person list
              Expanded(child: ListPersonWidget(
                callback: (person, index) {
                  bringPersonToUpdate(person, index);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

enum SaveButtonMode { save, edit }


