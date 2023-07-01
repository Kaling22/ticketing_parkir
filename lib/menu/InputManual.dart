
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketing_parkir/menu/InputKendaraanScreen.dart';
import 'package:ticketing_parkir/partial/DrawerScreen.dart';
// import 'package:ticketing_parkir/model/mahasiswa_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticketing_parkir/utils/end_points.dart';
class InputManual extends StatefulWidget {
  final String token;
  final String id;
  const InputManual({Key? key, required this.token, required this.id}) : super(key: key);
  @override
  State<InputManual> createState() => _InputManualState(token, id);
}

class _InputManualState extends State<InputManual> {

  Map? data;
  String? uri;
  String token;
  String id;
  final TextEditingController _inputController = TextEditingController();
  var apiURL = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.mahasiswa;
  var apiURLCreate = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.park;
  _InputManualState(this.token, this.id);
  //var token1 = InputManual.token;
String tex() {
  var para = _inputController.text;
  //await initStat();
  return para;
}
Future<void> text () async{
  tex();
  await initStat();
}

    Future <void> initStat()async{
      //final alamat = apiURL + nm;
      var respons = await http.get(Uri.parse(apiURL + tex()), headers: {'Accept': 'application/json','Authorization': 'Bearer $token'});
      var convertDataToJson = jsonDecode(respons.body);
        data = convertDataToJson['data'];
      print(data);
      await modal();
  }
  
  Future<void> createData() async {
    // Your API endpoint URL
    final url = Uri.parse(apiURLCreate);

    // Data to be sent in the request body
    // final dataCreate = {
    //   'nim': data!['nim'].toString(),
    //   'nfc_num': data!['nfc_num'].toString(),
    //   'nfc_num_ktp': data!['nfc_num_ktp'].toString(),
    //   'created_by': id,
    // };
    Map<String, dynamic> requestBody= {
      'nim': data!['nim'],
      'nfc_num': data!['nfc_num'],
      'nfc_num_ktp': data!['nfc_num_ktp'],
      'created_by': id,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Request successful
        print('POST request succeeded');
      } else {
        // Request failed
        print('POST request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error: $e');
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Masuk"),
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
              'Kendaraan Masuk',
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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _inputController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration.collapsed(
                    hintText: "NIM",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
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
                  onPressed: () async =>{
                    initStat(),
                    },
                  child: const Text(
                    "Simpan",
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

  Future<void> modal() async{
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled:true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 723,
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 20.0),
                  child: Container(
                    height: 8.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(const Radius.circular(8.0))
                    ),
                  ),
                ),
                const Text('Data Mahasiswa'),
                data == null ? Text('Data Kosong') :
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: 
                    Image.network(
                      ApiEndPoints.baseUrlimg+data!['foto'].toString(),
                      height: 80,
                      width: 80,
                    ),
                ),
                
                Text(data!['nim'].toString()),
                Text(data!['name'].toString()),
                Text(data!['angkatan'].toString()),
                Text(data!['jurusan'].toString()),
                Text(data!['fakultas'].toString()),
                Text(id!),
                Container(
            
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                      child: const Text('Kirim Data'),
                      onPressed: () {
                        createData();
                        Get.off(InputKendaraanScreen(token: token, id:id));}
                      ),
                      Padding(padding: const EdgeInsets.all(10)),
                      ElevatedButton(
                        child: const Text('Batal'),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                )
                
              ],
            ),
          ),
        );
      },
    );
                  
  }
}
