import 'package:flutter/material.dart';

class Pasien {
  String namaLengkap;
  String umurPasien;
  String idPasien;
  String ruangan;

  Pasien({
    required this.namaLengkap,
    required this.umurPasien,
    required this.idPasien,
    required this.ruangan,
  });
}

class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  List<Pasien> pasienList = [];

  TextEditingController namaController = TextEditingController();
  TextEditingController umurController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController ruanganController = TextEditingController();

  void createData() {
    Pasien pasien = Pasien(
      namaLengkap: namaController.text,
      umurPasien: umurController.text,
      idPasien: idController.text,
      ruangan: ruanganController.text,
    );
    pasienList.add(pasien);
    namaController.clear();
    umurController.clear();
    idController.clear();
    ruanganController.clear();
    setState(() {});
  }

  void readData() {
    _showReadDialog();
  }

  void _showReadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Pasien"),
          content: DropdownButton<Pasien>(
            items: pasienList.map((Pasien pasien) {
              return DropdownMenuItem<Pasien>(
                value: pasien,
                child: Text("${pasien.namaLengkap} - ${pasien.idPasien}"),
              );
            }).toList(),
            onChanged: (Pasien? selectedPasien) {
              if (selectedPasien != null) {
                _showPasienInfoDialog(selectedPasien);
              }
            },
          ),
        );
      },
    );
  }

  void _showPasienInfoDialog(Pasien pasien) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Informasi Pasien"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama: ${pasien.namaLengkap}"),
              Text("Umur: ${pasien.umurPasien}"),
              Text("ID: ${pasien.idPasien}"),
              Text("Ruangan: ${pasien.ruangan}"),
            ],
          ),
        );
      },
    );
  }

  void updateData() {
    if (pasienList.isNotEmpty) {
      _showUpdateDialog();
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Pasien"),
          content: DropdownButton<Pasien>(
            items: pasienList.map((Pasien pasien) {
              return DropdownMenuItem<Pasien>(
                value: pasien,
                child: Text("${pasien.namaLengkap} - ${pasien.idPasien}"),
              );
            }).toList(),
            onChanged: (Pasien? selectedPasien) {
              if (selectedPasien != null) {
                _showUpdateForm(selectedPasien);
              }
            },
          ),
        );
      },
    );
  }

  void _showUpdateForm(Pasien existingPasien) {
    TextEditingController updatedNamaController = TextEditingController();
    TextEditingController updatedUmurController = TextEditingController();
    TextEditingController updatedIdController = TextEditingController();
    TextEditingController updatedRuanganController = TextEditingController();

    updatedNamaController.text = existingPasien.namaLengkap;
    updatedUmurController.text = existingPasien.umurPasien;
    updatedIdController.text = existingPasien.idPasien;
    updatedRuanganController.text = existingPasien.ruangan;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Data Pasien"),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: updatedNamaController,
                decoration: InputDecoration(labelText: "Nama Lengkap"),
              ),
              TextFormField(
                controller: updatedUmurController,
                decoration: InputDecoration(labelText: "Umur Pasien"),
              ),
              TextFormField(
                controller: updatedIdController,
                decoration: InputDecoration(labelText: "ID Pasien"),
              ),
              TextFormField(
                controller: updatedRuanganController,
                decoration: InputDecoration(labelText: "Ruangan"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Pasien updatedPasien = Pasien(
                  namaLengkap: updatedNamaController.text,
                  umurPasien: updatedUmurController.text,
                  idPasien: updatedIdController.text,
                  ruangan: updatedRuanganController.text,
                );
                int index = pasienList.indexOf(existingPasien);
                pasienList[index] = updatedPasien;
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void deleteData() {
    if (pasienList.isNotEmpty) {
      pasienList.removeAt(0); // Remove the first item for demonstration
      print("Menghapus");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pasien"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: umurController,
                decoration: InputDecoration(
                    labelText: "Umur Pasien",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: idController,
                decoration: InputDecoration(
                    labelText: "ID Pasien",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                controller: ruanganController,
                decoration: InputDecoration(
                    labelText: "Ruangan",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: createData,
                      child:
                          Text("Create", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: readData,
                      child:
                          Text("Read", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: updateData,
                      child:
                          Text("Update", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: deleteData,
                      child:
                          Text("Delete", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: pasienList.length,
                itemBuilder: (context, index) {
                  Pasien pasien = pasienList[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Nama: ${pasien.namaLengkap}"),
                      subtitle: Text(
                          "Umur: ${pasien.umurPasien}, Ruangan: ${pasien.ruangan}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PasienPage(),
  ));
}
