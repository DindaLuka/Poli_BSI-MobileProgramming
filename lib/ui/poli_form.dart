import 'package:flutter/material.dart';
import '../model/poli.dart';
import './poli_detail.dart';
import '../service/poli_service.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({Key? key}) : super(key: key);
  _PoliFormState createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Poli")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _fieldNamaPoli(),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  Widget _fieldNamaPoli() {
    return TextFormField(
      controller: _namaPoliCtrl,
      decoration: InputDecoration(labelText: "Nama Poli"),
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        Poli poli = Poli(namaPoli: _namaPoliCtrl.text);
        await PoliService().simpan(poli).then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)),
            ));
      },
      child: Text("Simpan"),
    );
  }
}
