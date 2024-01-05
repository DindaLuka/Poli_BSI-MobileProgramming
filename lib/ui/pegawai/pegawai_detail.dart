import 'package:flutter/material.dart';
import 'package:aplikasi_poli/model/pegawai.dart';
import 'pegawai_service.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({Key? key, required this.pegawai}) : super(key: key);

  @override
  State<PegawaiDetail> createState() => _PegawaiDetailState();
}

class _PegawaiDetailState extends State<PegawaiDetail> {
  final _namaPegawaiCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaPegawaiCtrl.text = widget.pegawai.namaPegawai;
    _nipCtrl.text = widget.pegawai.nip;
    _tanggalLahirCtrl.text = widget.pegawai.tanggalLahir;
    _nomorTeleponCtrl.text = widget.pegawai.nomorTelepon;
    _emailCtrl.text = widget.pegawai.email;
    _passwordCtrl.text = widget.pegawai.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pegawai"),
        backgroundColor: Colors.deepOrange,
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDetailRow("ID Pegawai", "${widget.pegawai.idPegawai}"),
            _buildDetailTextField("Nama Pegawai", _namaPegawaiCtrl),
            _buildDetailTextField("NIP", _nipCtrl),
            _buildDetailTextField("Tanggal Lahir", _tanggalLahirCtrl),
            _buildDetailTextField("Nomor Telepon", _nomorTeleponCtrl),
            _buildDetailTextField("Email", _emailCtrl),
            _buildDetailTextField("Password", _passwordCtrl),
            SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "$label : $value",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildDetailTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(labelText: label),
        controller: controller,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _simpanPerubahan,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Simpan Perubahan"),
        ),
        ElevatedButton(
          onPressed: _showConfirmationDialog,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Hapus"),
        ),
      ],
    );
  }

  void _simpanPerubahan() {
    Pegawai pegawaiBaru = Pegawai(
      idPegawai: widget.pegawai.idPegawai,
      namaPegawai: _namaPegawaiCtrl.text,
      nip: _nipCtrl.text,
      tanggalLahir: _tanggalLahirCtrl.text,
      nomorTelepon: _nomorTeleponCtrl.text,
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
    );

    PegawaiService().listData().then((List<Pegawai> existingData) {
      int existingIndex = existingData.indexWhere((pegawai) => pegawai.idPegawai == widget.pegawai.idPegawai);

      if (existingIndex != -1) {
        // Jika pegawai sudah ada, lakukan pembaruan
        existingData[existingIndex] = pegawaiBaru;
      } else {
        // Jika pegawai belum ada, tambahkan pegawai baru
        existingData.add(pegawaiBaru);
      }

      PegawaiService().simpanSemua(existingData).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Perubahan berhasil disimpan'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pop();
      });
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Anda yakin ingin menghapus pegawai ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: _hapusPegawai,
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _hapusPegawai() {
    PegawaiService().hapus(widget.pegawai).then((value) {
      Navigator.of(context).pop();
    });
  }
}