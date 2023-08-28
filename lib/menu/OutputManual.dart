import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketing_parkir/menu/OutputKendaraanScreen.dart';
import 'package:ticketing_parkir/partial/DrawerScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticketing_parkir/utils/end_points.dart';
class OutputManual extends StatefulWidget {
  final String token;
  final String id;
  final String name;
  final String email;
  const OutputManual({Key? key, required this.token, required this.id,required this.name,required this.email}) : super(key: key);
  @override
  State<OutputManual> createState() => _OutputManualState(token, id,name,email);
}

class _OutputManualState extends State<OutputManual> {

  Map? data;
  String? uri;
  String token;
  String id;
  String name;
  String email;
  final TextEditingController _OutputController = TextEditingController();
  var apiURL = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.park;
  _OutputManualState(this.token, this.id,this.name,this.email);
  //var token1 = OutputManual.token;
String param() {
  var para = _OutputController.text;
  return para;
}
Future<void> allFunction() async{
  param();
  await initStat();
  await modal();
}

    Future <void> initStat()async{
      var respons = await http.get(Uri.parse(apiURL + param()), headers: {'Accept': 'application/json','Authorization': 'Bearer $token'});
      var convertDataToJson = jsonDecode(respons.body);
      data = convertDataToJson['data'];
      print(data);
  }
  
  Future<void> updateData() async {
    // Your API endpoint URL
    final url = Uri.parse(apiURL + param());

    // Data to be sent in the request body
    final dataUpdate = {'updated_by': id};
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
        body: json.encode(dataUpdate),
      );

      if (response.statusCode == 200) {
        // Request successful
        print('PUT request succeeded');
      } else {
        // Request failed
        print('PUT request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error: $e');
    }
  }
  


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
      drawer: DrawerScreen(token: token,id: id, name: name, email: email,),
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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _OutputController,
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
                    allFunction(),
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
          child: 
            data!['status_keluar']==1
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/warning.png',
                        height: 80,
                        width: 80,
                      ),
                      Text('Kendaraan Belum Terparkir Di Wilayah Kampus'),
                      ElevatedButton(
                        child: const Text('Batal'),
                        onPressed: () => Get.back(),
                      ),
                    ]
                  ),
                )
                :Container(
                child: Column(
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
                  Container(
                    child: Column(
                      children: [
                        data == null ? Text('Data Kosong') :
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: 
                            Image.network(
                              ApiEndPoints.baseUrlimg+data!['mahasiswa']['foto'].toString(),
                              height: 150,
                            ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            ListTile(
                                title: Text("NIM"),
                                subtitle: Text(data!['nim'].toString()) ,
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              ),
                            ListTile(
                              title: Text("Nama"),
                              subtitle: Text(data!['mahasiswa']['name'].toString()) ,
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                                title: Text("Angkatan"),
                                subtitle: Text(data!['mahasiswa']['angkatan'].toString()) ,
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                                title: Text("Jurusan"),
                                subtitle: Text(data!['mahasiswa']['jurusan'].toString()) ,
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                              title: Text("Fakultas"),
                              subtitle: Text(data!['mahasiswa']['fakultas'].toString()) ,
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                                title: Text("Nomer Kendaraan"),
                                subtitle: Text(data!['kendaraan'].toString()) ,
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            
                          ],
                        ),
                        
                      ],
                    )
                  ),
                  
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton(
                        child: const Text('Kirim Data'),
                        onPressed: () {
                          updateData();
                          Get.off(OutputKendaraanScreen(token: token, id:id, name:name,email:email));}
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
