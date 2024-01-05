import 'package:flutter/material.dart';
import '../widget/sidebar.dart';
import 'package:aplikasi_poli/ui/pegawai/pegawai_page.dart';
import '../ui/poli_page.dart';
import '../ui/login.dart';
import '../ui/pasien/pasien.dart';
// Import halaman PoliPage

class Beranda extends StatelessWidget {
  const Beranda({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text("Beranda"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Selamat Datang di Aplikasi",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Aplikasi ini memberikan pengalaman yang luar biasa!",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _handleIconTap(context, index);
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                _getIconForIndex(index),
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.accessible;
      case 1:
        return Icons.people;
      case 2:
        return Icons.account_box_sharp;
      case 3:
        return Icons.logout_rounded;
      default:
        return Icons.error;
    }
  }

  void _handleIconTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigasi ke halaman PoliPage saat icon accessible di-tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PoliPage()),
        );
        break;
      case 1:
        // Navigasi ke halaman PegawaiPage saat icon people di-tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PegawaiPage()),
        );
        break;
      case 2:
        // Navigasi ke halaman PoliPage saat icon account_box_sharp di-tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PasienPage()),
        );
        break;
      case 3:
        // Navigasi ke halaman Login saat icon logout_rounded di-tap
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false,
        );
        break;
    }
  }
}
