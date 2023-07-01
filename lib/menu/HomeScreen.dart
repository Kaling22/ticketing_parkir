import 'package:flutter/material.dart';

import 'package:ticketing_parkir/partial/DrawerScreen.dart';

import 'package:ticketing_parkir/menu/InputKendaraanScreen.dart';
import 'package:ticketing_parkir/menu/OutputKendaraanScreen.dart';
class HomeScreen extends StatefulWidget {
  final String token;
  final String id;
  const HomeScreen({Key? key, required this.token, required this.id}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState(token, id);
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;
  String? id;
  _HomeScreenState(this.token, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
      drawer: DrawerScreen(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Color.fromARGB(5, 17, 17, 17),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Home",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              menu_item(context)
            ],
          ),
        ),
      ),
    );
  }

  Container menu_item(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => InputKendaraanScreen(token: widget.token, id:widget.id)));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/parkir_icon.jpg",
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Kendaraan Masuk",
                    style: titleStyle(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Memasukkan data parkir baru",
                    style: subTitle(),
                  ),
                ],
              ),
            ),
          ),
          new GestureDetector(
            
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => OutputKendaraanScreen(token: widget.token, id: widget.id,)));
            },
            child: new Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/parkir_icon.jpg",
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Kendaraan Keluar",
                    style: titleStyle(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Kendaraan keluar wilayah kampus",
                    style: subTitle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle positionText() {
    return TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w400);
  }

  TextStyle subTitle() => TextStyle(
      fontWeight: FontWeight.w500, color: Color.fromARGB(255, 0, 0, 0));

  TextStyle titleStyle() {
    return TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w700);
  }
}
