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
  OutputKendaraanScreen({Key? key, required this.token, required this.id}) : super(key: key);

  @override
  State<OutputKendaraanScreen> createState() => _OutputKendaraanScreenState(token,id);
}

class _OutputKendaraanScreenState extends State<OutputKendaraanScreen> {
  String token;
  String id;
  String? nfc;
  var nfcNumber;
  Map? data;
  String? uri;
  var apiURL = ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.park;
  _OutputKendaraanScreenState(this.token, this.id);

   @override
    void initState() {
      super.initState();
      initNFCManager();
      //await text ();
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
          text();
          return nfcNumber;
      });
      print('NFC Manager initialized.');
      return nfcNumber;
  }
  String tex(){
    var para =initNFCManager().toString();
    return para;
  }
  Future<void> text () async{
    tex();
    await initStat();
  }

  Future <void> initStat()async{
      //final alamat = apiURL + nm;
      var respons = await http.get(Uri.parse(apiURL + nfcNumber), headers: {'Accept': 'application/json','Authorization': 'Bearer $token'});
      var convertDataToJson = jsonDecode(respons.body);
        data = convertDataToJson['data'];
      print(data);
      await modal();
  }
  
  Future<void> updateData() async {
    // Your API endpoint URL
    final url = Uri.parse(apiURL + nfcNumber);

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
      drawer: DrawerScreen(token: token),
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
                      ApiEndPoints.baseUrlimg+data!['mahasiswa']['foto'].toString(),
                      height: 80,
                      width: 80,
                    ),
                    
                ),
                
                Text(data!['nim'].toString()),
                Text(data!['mahasiswa']['name'].toString()),
                Text(data!['mahasiswa']['angkatan'].toString()),
                Text(data!['mahasiswa']['jurusan'].toString()),
                Text(data!['mahasiswa']['fakultas'].toString()),
                Container(
            
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                      child: const Text('Kirim Data'),
                      onPressed: () {
                        updateData();
                        Get.off(OutputKendaraanScreen(token: token, id:id));}
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

