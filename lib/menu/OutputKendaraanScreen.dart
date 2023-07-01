import 'package:flutter/material.dart';
import 'package:ticketing_parkir/menu/OutputManual.dart';
import 'package:ticketing_parkir/partial/DrawerScreen.dart';

// ignore: must_be_immutable
class OutputKendaraanScreen extends StatefulWidget {
  final String token;
  final String id;
  OutputKendaraanScreen({Key? key, required this.token, required this.id}) : super(key: key);

  @override
  State<OutputKendaraanScreen> createState() => _OutputKendaraanScreenState(token,id);
}

class _OutputKendaraanScreenState extends State<OutputKendaraanScreen> {
  String? token;
  String? id;
  _OutputKendaraanScreenState(this.token, this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keluar"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
      drawer: DrawerScreen(),
      body: Container(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kendaraan Keluar',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => OutputManual(token: widget.token, id:widget.id)));
                  },
                  child: const Text(
                    "Input NIM Manual",
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 17, 17),
                        fontWeight: FontWeight.w500),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
