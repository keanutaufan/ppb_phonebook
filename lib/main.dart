import 'package:flutter/material.dart';
import 'package:myapp/database/app_database.dart';
import 'package:myapp/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PPB Phonebook',
      home: MainPage(),
    );
  }
}
