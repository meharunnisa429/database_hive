import 'package:database_hive_2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:database_hive_2/database/model/person.dart';

// Declare variable globally
late final Box<Person> boxPerson;

Future<void> main() async {
  // Initialize Hive and register adapters if needed
  await Hive.initFlutter();
  // Register the adapter
  // or Register only if it is not registered before
  if (!Hive.isAdapterRegistered(PersonAdapter().typeId)) {
    Hive.registerAdapter(PersonAdapter());
  }
  //open a new personBox
  boxPerson = await Hive.openBox<Person>("personBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
