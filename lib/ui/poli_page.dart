import 'package:flutter/material.dart';
import './poli_item.dart';
import '../model/poli.dart';
import './poli_form.dart';
import '../widget/sidebar.dart';
import '../service/poli_service.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});
  _PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  Stream<List<Poli>> getList() async* {
    List<Poli> data = await PoliService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text("Data Poli"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PoliForm()));
              },
              child: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
          stream: getList(),
          builder: (context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  PoliItem(poli: snapshot.data[index]),
            );
          }),
    );
  }
}
