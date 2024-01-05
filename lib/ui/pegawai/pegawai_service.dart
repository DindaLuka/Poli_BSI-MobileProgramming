import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aplikasi_poli/model/pegawai.dart';

class PegawaiService {
  static const String _prefsKey = 'pegawai_list';

  Future<List<Pegawai>> listData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString(_prefsKey);

    if (storedData != null && storedData.isNotEmpty) {
      List<dynamic> data = json.decode(storedData);
      return data.map((item) => Pegawai.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<void> simpan(Pegawai pegawai) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Pegawai> existingData = await listData();

    // Assign ID untuk pegawai yang baru ditambahkan
    pegawai.idPegawai = DateTime.now().millisecondsSinceEpoch;

    existingData.add(pegawai);
    String newData = json.encode(existingData.map((item) => item.toJson()).toList());
    await prefs.setString(_prefsKey, newData);
  }

  Future<void> hapus(Pegawai pegawai) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Pegawai> existingData = await listData();

    existingData.removeWhere((item) => item.idPegawai == pegawai.idPegawai);
    String newData = json.encode(existingData.map((item) => item.toJson()).toList());
    await prefs.setString(_prefsKey, newData);
  }

  Future<void> simpanSemua(List<Pegawai> pegawaiList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newData = json.encode(pegawaiList.map((item) => item.toJson()).toList());
    await prefs.setString(_prefsKey, newData);
  }
}





/*import 'dart:convert';
import 'package:http/http.dart' as http;
import '/model/pegawai.dart';

class PegawaiService {
  final String apiUrl = "https://example.com/api/pegawai";

  Future<List<Pegawai>> listData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Pegawai.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<Pegawai> simpan(Pegawai pegawai) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(pegawai.toJson()),
    );

    if (response.statusCode == 201) {
      return Pegawai.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to save data");
    }
  }

  Future<void> hapus(Pegawai pegawai) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/${pegawai.idPegawai}'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 204) {
      throw Exception("Failed to delete data");
    }
  }
}*/