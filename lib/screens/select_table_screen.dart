import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';

class SelectTableScreen extends StatefulWidget {
  const SelectTableScreen({super.key});

  @override
  _SelectTableScreenState createState() => _SelectTableScreenState();
}

class _SelectTableScreenState extends State<SelectTableScreen> with SingleTickerProviderStateMixin {
  List<int> tables = [];
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    loadTablesFromJson();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  Future<void> loadTablesFromJson() async {
    try {
      final jsonString = await rootBundle.rootBundle.loadString('assets/tables.json');
      print('JSON String: $jsonString'); // Imprime el JSON para verificar
      final data = json.decode(jsonString);
      print('Decoded JSON: $data'); // Imprime los datos decodificados
      setState(() {
        tables = List<int>.from(data['tables'].map((table) => table['id']));
      });
    } catch (e) {
      print('Error loading tables.json: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Mesa"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: tables.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _controller?.forward(from: 0.0);
              // Acción al seleccionar una mesa
            },
            child: ScaleTransition(
              scale: CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Mesa ${tables[index]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
