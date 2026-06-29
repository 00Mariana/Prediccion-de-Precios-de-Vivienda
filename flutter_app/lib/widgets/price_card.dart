import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final double price;

  const PriceCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.attach_money,
              size: 48,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            const Text(
              'Precio Estimado',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getPriceCategory(price),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPriceCategory(double price) {
    if (price < 150000) return 'Categoria: Economica';
    if (price < 300000) return 'Categoria: Intermedia';
    if (price < 500000) return 'Categoria: Alta';
    return 'Categoria: Premium';
  }
}
