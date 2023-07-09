
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketing_parkir/menu/InputKendaraanScreen.dart';
import 'package:ticketing_parkir/partial/DrawerScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ticketing_parkir/utils/end_points.dart';
class InputManual extends StatefulWidget {
  final String token;
  final String id;
  final String name;
  final String email;
  const InputManual({Key? key, required this.token, required this.id,required this.name,required this.email}) : super(key: key);
  @override
  State<InputManual> createState() => _InputManualState(token, id,name,email);
}

class _InputManualState extends State<InputManual> {

  Map? data;
  Map? dataParkir;
  String? uri;
  String token;
  String id;
  String name;
  String email;
  final TextEditingController _inputController = TextEditingController();
  var apiURL = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.mahasiswa;
  var apiURLParkir = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.park;
  var apiURLCreate = ApiEndPoints.baseUrl2 + ApiEndPoints.authEndPoints.park2;
  _InputManualState(this.token, this.id,this.name,this.email);
  //var token1 = InputManual.token;
  String tex() {
    var para = _inputController.text;
    //await initStat();
    return para;
  }
  Future<void> text () async{
    tex();
    await getDataParkir();
    await initStat();
    await modal();
  }

    Future <void> initStat()async{
      //final alamat = apiURL + nm;
      var respons = await http.get(Uri.parse(apiURL + tex()), headers: {'Accept': 'application/json','Authorization': 'Bearer $token'});
      var convertDataToJson = jsonDecode(respons.body);
        data = convertDataToJson['data'];
      //print(data);
      //await modal();
    }
    Future <void> getDataParkir()async{
      //final alamat = apiURL + nm;
      var respons = await http.get(Uri.parse(apiURLParkir + tex()), headers: {'Accept': 'application/json','Authorization': 'Bearer $token'});
      var convertDataToJson = jsonDecode(respons.body);
        dataParkir = convertDataToJson['data'];
    }
  
  Future<void> createData() async {
    // Your API endpoint URL
    final url = Uri.parse(apiURLCreate);
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
      drawer: DrawerScreen(token: token,id: id, name: name, email: email,),
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
                    text()
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
            dataParkir!['status_masuk']==1
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/warning.png',
                        height: 80,
                        width: 80,
                      ),
                      Text('Kendaraan Masih Terparkir Di Wilayah Kampus'),
                      ElevatedButton(
                        child: const Text('Batal'),
                        onPressed: () => Get.back(),
                      ),
                    ]
                  ),
                )
                :Container(
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
                  Container(
                    child: Column(
                      children: [
                        data == null ? Text('Data Kosong') :
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: 
                            Image.network(
                              ApiEndPoints.baseUrlimg+data!['foto'].toString(),
                              height: 150,
                              //width: ,
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
                              subtitle: Text(data!['name'].toString()) ,
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                                title: Text("Angkatan"),
                                subtitle: Text(data!['angkatan'].toString()) ,
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                                title: Text("Jurusan"),
                                subtitle: Text(data!['jurusan'].toString()) ,
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            ),
                            ListTile(
                              title: Text("Fakultas"),
                              subtitle: Text(data!['fakultas'].toString()) ,
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
                          createData();
                          Get.off(InputKendaraanScreen(token: token, id:id,name: name,email: email,));}
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
