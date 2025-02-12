// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:database_hive_2/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:database_hive_2/database/functions/db_functions.dart';
import 'package:database_hive_2/database/model/person.dart';

class AddPersonWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final FocusNode nameFocusNode;
  final FocusNode ageFocusNode;
  final ValueNotifier<SaveButtonMode> saveButtonMode;
  final ValueNotifier<int?> indexToUpdate;
  const AddPersonWidget(
      {super.key,
      required this.nameController,
      required this.ageController,
      required this.nameFocusNode,
      required this.ageFocusNode,
      required this.saveButtonMode,
      required this.indexToUpdate});

  @override
  State<AddPersonWidget> createState() => _AddPersonWidgetState();
}

class _AddPersonWidgetState extends State<AddPersonWidget> {
  void _unFocusAllFocusNode() {
    widget.nameFocusNode.unfocus();
    widget.ageFocusNode.unfocus();
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.nameController,
          focusNode: widget.nameFocusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Name"),
            hintText: "Enter name",
            hintStyle: TextStyle(color: Colors.black38),
          ),
        ),

        const SizedBox(
          height: 8,
        ),
        // age textfield
        TextField(
          controller: widget.ageController,
          focusNode: widget.ageFocusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Age"),
            hintText: "Enter age",
            hintStyle: TextStyle(color: Colors.black38),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(
          height: 8,
        ),

        // save or update button
        ValueListenableBuilder<SaveButtonMode>(
          valueListenable: widget.saveButtonMode,
          builder: (context, mode, _) {
            return ElevatedButton(
              onPressed: () {
                final name = widget.nameController.text.trim();
                final ageText = widget.ageController.text.trim();

                if (name.isEmpty || ageText.isEmpty) {
                  _showSnackbar(context, "Please enter all details");
                  return;
                }

                final age = int.tryParse(ageText);
                if (age == null) {
                  _showSnackbar(context, "Please enter a valid age");
                  return;
                }

                final person = Person(name, age);

                if (mode == SaveButtonMode.save) {
                  addPerson(person);
                } else {
                  updatePerson(person, widget.indexToUpdate.value!);
                  widget.saveButtonMode.value = SaveButtonMode.save;
                  widget.indexToUpdate.value = null;
                }

                widget.nameController.clear();
                widget.ageController.clear();
                _unFocusAllFocusNode();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      mode == SaveButtonMode.save ? Colors.green : Colors.blue,
                  foregroundColor: Colors.white),
              child: Text(mode == SaveButtonMode.save ? "Save" : "Update"),
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
