// pegawai_form.dart
import 'package:flutter/material.dart';
import 'package:aplikasi_poli/model/pegawai.dart';
import 'pegawai_service.dart';
//import 'pegawai_detail.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);

  @override
  _PegawaiFormState createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pegawai",style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.deepOrange,
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _fieldNamaPegawai(),
              _fieldNip(),
              _fieldTanggalLahir(),
              _fieldNomorTelepon(),
              _fieldEmail(),
              _fieldPassword(),
              const SizedBox(height: 20),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  _fieldNamaPegawai() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Pegawai",
        border: OutlineInputBorder(),
        ),
      controller: _namaPegawaiCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Pegawai tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldNip() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "NIP",
        border: OutlineInputBorder(),
        ),
      controller: _nipCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'NIP tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldTanggalLahir() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Tanggal Lahir",
        border: OutlineInputBorder(),
        ),
      controller: _tanggalLahirCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tanggal Lahir tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldNomorTelepon() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nomor Telepon",
        border: OutlineInputBorder(),
        ),
      controller: _nomorTeleponCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor Telepon tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldEmail() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),),
      controller: _emailCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  _fieldPassword() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
      controller: _passwordCtrl,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        return null;
      },
    );
  }

  /*_tombolSimpan() {
  return ElevatedButton.icon(
    onPressed: () async {
      if (_formKey.currentState?.validate() ?? false) {
        Pegawai pegawai = Pegawai(
          idPegawai: DateTime.now().millisecondsSinceEpoch, // Contoh pemberian ID unik
          namaPegawai: _namaPegawaiCtrl.text,
          nip: _nipCtrl.text,
          tanggalLahir: _tanggalLahirCtrl.text,
          nomorTelepon: _nomorTeleponCtrl.text,
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
        );
        await PegawaiService().simpan(pegawai).then((value) {
          Navigator.pop(context); // Kembali ke halaman sebelumnya setelah penyimpanan berhasil
        });
      }
    },
      style: ElevatedButton.styleFrom(
        primary: Colors.deepOrange,
        fixedSize: Size(50, 40),
      ),
      //child: const Text("Simpan", style: TextStyle(fontSize: 18)),
      icon: Icon(Icons.save), // Tambahkan ikon "save"
      label: Text("Simpan", style: TextStyle(fontSize: 18)),
  );
}*/
_tombolSimpan() {
  return InkWell(
    onTap: () async {
      if (_formKey.currentState?.validate() ?? false) {
        Pegawai pegawai = Pegawai(
          idPegawai: DateTime.now().millisecondsSinceEpoch,
          namaPegawai: _namaPegawaiCtrl.text,
          nip: _nipCtrl.text,
          tanggalLahir: _tanggalLahirCtrl.text,
          nomorTelepon: _nomorTeleponCtrl.text,
          email: _emailCtrl.text,
          password: _passwordCtrl.text,
        );
        await PegawaiService().simpan(pegawai).then((value) {
          Navigator.pop(context);
        });
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.save, color: Colors.white),
            SizedBox(width: 10),
            Text("Simpan", style: TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    ),
  );
}
}


///////INI FILE ASLINYA
/*import 'package:flutter/material.dart';

class PegawaiForm extends StatefulWidget{
  const PegawaiForm({Key? key}) :super(key: key);
  _PegawaiFormState createState()=> _PegawaiFormState();

}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNamaPegawai(),
              SizedBox(height: 20),
              _tombolSimpan()
            ],
          ),
        ),
      ),  
    );  
  }

  _fieldNamaPegawai(){
    return TextField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
    );
  }

  _tombolSimpan(){
    return ElevatedButton(onPressed: () {}, child: const Text("Simpan"));
  }
}*/