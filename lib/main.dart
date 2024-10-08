import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polideportivo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContentList(),
    );
  }
}

class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  List<dynamic> contents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContents();
  }

  Future<void> fetchContents() async {
    final response = await http.get(Uri.parse('http://localhost/Api/v1/contenido.php'));
                                              /* ESTA LINEA DE CODIGO DE MODIFICA CON LA IP DEL LA COMPUTARA DE CAMBIA LA PALARA DE LOCALHOST POR LA IP */

    if (response.statusCode == 200) {
      setState(() {
        contents = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Error al cargar los contenidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contenidos'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: contents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contents[index]['titulo']),
                  subtitle: Text(contents[index]['descripcion']),
                );
              },
            ),
    );
  }
}
