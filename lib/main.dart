import 'package:flutter/material.dart';
import 'package:ticketing_parkir/login/LoginScreen.dart';
import 'package:get/get.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ticketing Parkir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 99, 152, 223),
      ),
      home: LoginScreen(),
    );
  }
}
