import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:ticketing_parkir/login/LoginScreen.dart';
import 'package:ticketing_parkir/utils/end_points.dart';

class DrawerScreen extends StatefulWidget {
  final token;

  const DrawerScreen({super.key, required this.token});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState(token);
}

class _DrawerScreenState extends State<DrawerScreen> {
  String token;
  _DrawerScreenState(this.token);

  // Method to Logout
  Future<void> logout() async {
    // Your API endpoint URL
    var apiURL = ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.logoutEmail;
    final url = Uri.parse(apiURL);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        // Request successful
        print('Logout succeeded');
      } else {
        // Request failed
        print('Logout failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('user'),
          currentAccountPicture:
              CircleAvatar(backgroundImage: AssetImage("assets/images/parkir_icon.jpg")),
          accountEmail: Text('User E-mail'),
        ),
        DrawerListTile(
          iconData: Icons.logout,
          title: "Log-Out",
          onTilePressed: () => {
            logout(),
            Get.offAll(LoginScreen())
          }
        )    
      ],
    ));
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final VoidCallback? onTilePressed;

  const DrawerListTile(
      {Key? key, this.iconData, this.title, this.onTilePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title!,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

