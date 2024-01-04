import 'package:flutter/material.dart';
import '../ui/beranda.dart';
import '../ui/poli_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Beranda()));
            },
          ),
          ListTile(
              leading: Icon(Icons.accessible),
              title: Text("Poli"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PoliPage()));
              }),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Pegawai"),
          ),
          ListTile(
            leading: Icon(Icons.account_box_sharp),
            title: Text("Pasien"),
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Keluar"),
          ),
        ],
      ),
    );
  }
}
