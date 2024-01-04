import 'package:flutter/material.dart';
import '../model/poli.dart';
import './poli_update_form.dart';
import '../service/poli_service.dart';
import './poli_page.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({Key? key, required this.poli}) : super(key: key);
  _PoliDetailState createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  Stream<Poli?> getData() async* {
    Poli? data = await PoliService().getById(widget.poli.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Poli")),
      body: StreamBuilder<Poli?>(
        stream: getData(),
        builder: (context, AsyncSnapshot<Poli?> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }
          return Column(
            children: [
              const SizedBox(height: 13),
              Text("Nama Poli : " + (snapshot.data?.namaPoli ?? ''),
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PoliUpdateForm(poli: widget.poli)));
                      },
                      child: const Text("Ubah"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff70e774))),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                alertDialog(context, widget.poli));
                      },
                      child: const Text("Hapus"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffea4a3f)))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

Widget alertDialog(BuildContext context, Poli poli) {
  return AlertDialog(
    content: const Text("Anda Yakin Ingin Menghapus Data Tersebut?"),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(primary: const Color(0xff51b554)),
          child: const Text("TIDAK")),
      ElevatedButton(
          onPressed: () async {
            await PoliService().hapus(poli);
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const PoliPage()));
          },
          style: ElevatedButton.styleFrom(primary: const Color(0xfff13d31)),
          child: const Text("YA"))
    ],
  );
}
