import 'package:flutter/material.dart';

class AddDishScreen extends StatefulWidget {
  final Map<String, dynamic>? dish;
  final Function(Map<String, dynamic>) onDishAdded;

  const AddDishScreen({super.key, this.dish, required this.onDishAdded});

  @override
  _AddDishScreenState createState() => _AddDishScreenState();
}

class _AddDishScreenState extends State<AddDishScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String _category = 'Bebidas';

  @override
  void initState() {
    super.initState();
    if (widget.dish != null) {
      _nameController.text = widget.dish!['nombre'];
      _priceController.text = widget.dish!['precio'].toString();
      _category = widget.dish!['categoria'];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveDish() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final price = double.parse(_priceController.text);

      widget.onDishAdded({
        'nombre': name,
        'precio': price,
        'categoria': _category,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dish == null ? 'Agregar Plato' : 'Modificar Plato'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Plato',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el nombre del plato';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el precio';
                }
                if (double.tryParse(value) == null || double.parse(value) <= 0) {
                  return 'Por favor, ingrese un precio válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _category = value!;
                });
              },
              items: ['Bebidas', 'Entradas', 'Plato Principal', 'Postres']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveDish,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(widget.dish == null ? 'Agregar Plato' : 'Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
