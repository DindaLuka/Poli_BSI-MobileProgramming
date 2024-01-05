import 'package:flutter/material.dart';
import '/model/pegawai.dart';
import 'pegawai_item.dart';
import 'pegawai_form.dart';
import 'pegawai_service.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  late Future<List<Pegawai>> _pegawaiListFuture;

  @override
  void initState() {
    super.initState();
    _pegawaiListFuture = PegawaiService().listData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Data Pegawai RS"),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PegawaiForm()),
              ).then((_) {
                // Set state untuk merefresh data setelah menambah pegawai
                setState(() {
                  _pegawaiListFuture = PegawaiService().listData();
                });
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<Pegawai>>(
        future: _pegawaiListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Pegawai> pegawaiList = snapshot.data!;
            return ListView.builder(
              itemCount: pegawaiList.length,
              itemBuilder: (context, index) {
                Pegawai pegawai = pegawaiList[index];
                return PegawaiItem(pegawai: pegawai);
              },
            );
          } else {
            return Center(
              child: Text('Tidak ada data'),
            );
          }
        },
      ),
    );
  }
}