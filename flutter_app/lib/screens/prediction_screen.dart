import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/input_form.dart';
import '../widgets/price_card.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  double? _predictedPrice;
  bool _isLoading = false;
  String? _error;

  // TODO: Definir las variables del formulario segun las features del modelo
  final Map<String, dynamic> _formData = {
    'GrLivArea': 0,
    'TotalBsmtSF': 0,
    'GarageCars': 0,
    'FullBath': 0,
    'YearBuilt': 0,
    // Agregar mas campos segun el modelo
  };

  Future<void> _predict() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final price = await ApiService.predictPrice(_formData);
      setState(() {
        _predictedPrice = price;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predecir Precio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ingresa las caracteristicas de la vivienda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // TODO: Reemplazar con InputForm widget
            InputForm(
              onChanged: (field, value) {
                _formData[field] = value;
              },
            ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: _isLoading ? null : _predict,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.calculate),
              label: Text(_isLoading ? 'Calculando...' : 'Predecir Precio'),
            ),

            const SizedBox(height: 24),

            if (_error != null)
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: $_error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),

            if (_predictedPrice != null)
              PriceCard(price: _predictedPrice!),
          ],
        ),
      ),
    );
  }
}
