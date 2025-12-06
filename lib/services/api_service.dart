import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/card_model.dart';

class ApiService {
  static const String baseUrl = 'https://www.amiiboapi.com/api';

  static Future<List<AmiiboModel>> getAmiibos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/amiibo/'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['amiibo'];
        return data.map((json) => AmiiboModel.fromJson(json)).toList();
      } else {
        throw Exception('falha ao carregar amiibos');
      }
    } catch (e) {
      throw Exception('erro ao buscar amiibos: $e');
    }
  }
}
