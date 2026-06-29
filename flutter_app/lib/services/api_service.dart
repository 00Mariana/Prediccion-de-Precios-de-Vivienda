import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // TODO: Cambiar por la URL de tu API cuando este desplegada
  static const String baseUrl = 'http://localhost:8000';

  /// Envia los datos de la vivienda y retorna el precio predecido
  static Future<double> predictPrice(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['predicted_price'].toDouble();
    } else {
      throw Exception('Error al predecir precio: ${response.statusCode}');
    }
  }

  /// Obtiene informacion del modelo (opcional, para dashboard)
  static Future<Map<String, dynamic>> getModelInfo() async {
    final response = await http.get(
      Uri.parse('$baseUrl/model-info'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener info del modelo');
    }
  }
}
