import 'package:flutter/material.dart';
import 'package:ticketing_parkir/partial/DrawerScreen.dart';

class OutputKendaraanScreen extends StatelessWidget {
  OutputKendaraanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input"),
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
            // Container(
            //   height: 50,
            //   width: double.infinity,
            //   padding: EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //       border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: TextFormField(
            //     keyboardType: TextInputType.number,
            //     controller: _nimController,
            //     style: TextStyle(color: Colors.white),
            //     decoration: InputDecoration.collapsed(
            //         hintText: "NIM",
            //         hintStyle: TextStyle(color: Colors.white)),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/OutputManual');
                  },
                  child: const Text(
                    "Input NIM Manual",
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 17, 17),
                        fontWeight: FontWeight.w500),
                  )),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   height: 50,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 255, 255, 255),
            //       border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: TextButton(
            //       onPressed: (){
            //         Navigator.pushNamed(context, '/Home');
            //       },
            //       child: const Text(
            //         "Simpan",
            //         style: TextStyle(
            //             color: Color.fromARGB(255, 17, 17, 17),
            //             fontWeight: FontWeight.w500),
            //       )),
            // ),
          ],
        ),
      )),
    );
  }
}
