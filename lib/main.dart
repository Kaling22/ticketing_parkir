import 'package:flutter/material.dart';
import 'package:ticketing_parkir/login/LoginScreen.dart';
import 'package:ticketing_parkir/menu/HomeScreen.dart';
import 'package:ticketing_parkir/menu/InputKendaraanScreen.dart';
import 'package:ticketing_parkir/menu/OutputKendaraanScreen.dart';
import 'package:ticketing_parkir/menu/InputManual.dart';
import 'package:ticketing_parkir/menu/OutputManual.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketing Parkir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 99, 152, 223),
      ),

      //initialRoute: '/',
      home: LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/Home': (context) => HomeScreen(),
        '/Login': (context) => LoginScreen(),
        '/Input': (context) => InputKendaraanScreen(),
        '/Output': (context) => OutputKendaraanScreen(),
        '/InputManual': (context) => InputManual(),
        '/OutputManual': (context) => OutputManual()
        
      },
    );
  }
}
