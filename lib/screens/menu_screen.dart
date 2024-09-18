import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Map<String, List<dynamic>> menu = {
    "bebidas": [],
    "entradas": [],
    "platos_principales": [],
    "postres": []
  };

  @override
  void initState() {
    super.initState();
    _cargarMenuDesdeJson();
  }

  Future<void> _cargarMenuDesdeJson() async {
    try {
      final jsonString = await rootBundle.loadString('assets/menu.json');
      final data = json.decode(jsonString);
      setState(() {
        menu = Map<String, List<dynamic>>.from(data['menu']);
      });
    } catch (e) {
      print('Error al cargar el menú: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menú'),
          backgroundColor: Colors.teal,
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Bebidas'),
              Tab(text: 'Entradas'),
              Tab(text: 'Platos principales'),
              Tab(text: 'Postres'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _construirListaMenu(menu['bebidas']),
            _construirListaMenu(menu['entradas']),
            _construirListaMenu(menu['platos_principales']),
            _construirListaMenu(menu['postres']),
          ],
        ),
      ),
    );
  }

  Widget _construirListaMenu(List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return const Center(child: Text('No hay elementos disponibles.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              item['nombre'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              item['descripcion'] ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: Text(
              "\$${item['precio'].toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
          ),
        );
      },
    );
  }
}
