import 'dart:async';

import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ticketing_parkir/menu/OutputManual.dart';
import 'package:ticketing_parkir/partial/DrawerScreen.dart';
import 'package:http/http.dart' as http;
import 'package:ticketing_parkir/utils/end_points.dart';
import 'package:get/get.dart';
import 'dart:convert';
// ignore: must_be_immutable
class OutputKendaraanScreen extends StatefulWidget {
  final String token;
  final String id;
  final String name;
  final String email;
  OutputKendaraanScreen({Key? key, required this.token, required this.id,required this.name,required this.email}) : super(key: key);

  @override
  State<OutputKendaraanScreen> createState() => _OutputKendaraanScreenState(token,id,name,email);
}

class _OutputKendaraanScreenState extends State<OutputKendaraanScreen> {
  String token;
  String id;
  String name;
  String email;
  String? nfc;
  var nfcNumber;
  Map? data;
  String? uri;
  var apiURL = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.park;
  _OutputKendaraanScreenState(this.token, this.id,this.name,this.email);

   @override
    void initState() {
      if (mounted) { 
        setState (() => _OutputKendaraanScreenState(token, id, name, email));
      }
      super.initState();
      initNFCManager();
    }
    
  String fromBytesToInt32(int b3, int b2, int b1, int b0) {
    final int8List = new Int8List(4)
      ..[3] = b3
      ..[2] = b2
      ..[1] = b1
      ..[0] = b0;
    var val = int8List.buffer.asByteData().getInt32(0).toString();
    return val;
  }
  Future<void> initNFCManager() async {
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
          var tagId = tag.data["nfca"]["identifier"];
          print('Tag ID: $tagId');
          final nfc = fromBytesToInt32(tagId[0], tagId[1], tagId[2], tagId[3]).toString().padLeft(10, '0');
          nfcNumber =nfc.toString();
          print(nfcNumber.toString());
          allFunction();
          return nfcNumber;
      });
      print('NFC Manager initialized.');
      return nfcNumber;
  }
  Future<void> allFunction () async{
    await getDataParkir();
    await modal();
  }

  Future <void> getDataParkir()async{
      var respons = await http.get(Uri.parse(apiURL + nfcNumber), headers: {'Accept': 'application/json','Authorization': 'Bearer $token'});
      var convertDataToJson = jsonDecode(respons.body);
        data = convertDataToJson['data'];
  }
  
  Future<void> updateData() async {
    final url = Uri.parse(apiURL + nfcNumber);

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
  
  //UI
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
      drawer: DrawerScreen(token: token,id: id, name: name, email: email,),
      body: Container(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
             Container(
              child: Container(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  child: Text(
                    "+ NIM", 
                    style: TextStyle(
                      color: Colors.black
                    ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => OutputManual(token: widget.token, id:widget.id, name: widget.name,email: widget.email,)));
                  },
                ),     
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFDFDFDF)
                ),
                borderRadius: BorderRadius.circular(10),
               color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Text(
              'Silahkan Lakukan Proses Scanning Kartu',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
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
                          Get.back();
                          }
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

