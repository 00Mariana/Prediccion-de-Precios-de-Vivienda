import 'package:flutter/material.dart';
import '../widgets/feature_chart.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparacion de Modelos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rendimiento de Modelos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // TODO: Grafica de barras comparando R2 de cada modelo
            Expanded(
              child: FeatureChart(
                // Pasar datos de comparacion aqui
                title: 'Comparacion R² Score',
              ),
            ),

            const SizedBox(height: 16),

            // TODO: Tabla con metricas detalladas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Metricas Detalladas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // TODO: Llenar con datos reales del modelo
                    _buildMetricRow('Arbol (squared_error)', 'R2: --', 'RMSE: --'),
                    _buildMetricRow('Arbol (friedman_mse)', 'R2: --', 'RMSE: --'),
                    _buildMetricRow('Arbol (poisson)', 'R2: --', 'RMSE: --'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String model, String r2, String rmse) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(model, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(r2)),
          Expanded(child: Text(rmse)),
        ],
      ),
    );
  }
}
