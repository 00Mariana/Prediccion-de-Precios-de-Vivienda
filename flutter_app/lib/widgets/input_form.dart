import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final Function(String, dynamic) onChanged;

  const InputForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Caracteristicas de la Vivienda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // TODO: Agregar todos los campos segun las features del modelo
            // Estos son ejemplos - ajustar segun tu dataset

            _buildTextField('Superficie (m2)', 'GrLivArea', 'Ej: 150'),
            _buildTextField('Superficie sotano (m2)', 'TotalBsmtSF', 'Ej: 80'),
            _buildTextField('Cocheras', 'GarageCars', 'Ej: 2'),
            _buildTextField('Banos completos', 'FullBath', 'Ej: 2'),
            _buildTextField('Ano construccion', 'YearBuilt', 'Ej: 2005'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String field, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
          final numericValue = double.tryParse(value) ?? 0;
          onChanged(field, numericValue);
        },
      ),
    );
  }
}
