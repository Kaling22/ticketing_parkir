import 'package:flutter/material.dart';
import 'package:ticketing_parkir/login/LoginScreen.dart';
import 'package:ticketing_parkir/menu/HomeScreen.dart';

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
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color.fromARGB(5, 17, 17, 17),
      ),

      //initialRoute: '/',
      // home: Login(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomeScreen(),
        '/Login': (context) => LoginScreen()
        // '/agent': (context) => GetDataScreen(),
        // '/weapon': (context) => GetDataWeapon(),
      },
    );
  }
}
