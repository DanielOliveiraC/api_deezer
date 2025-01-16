import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://api.deezer.com/search";

  Future<List<dynamic>> search(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?q=$query'));

      print('Status Code: ${response.statusCode}'); // Verificar o status da resposta
      print('Response Body: ${response.body}'); // Verificar o corpo da resposta

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Verificar se a chave 'data' existe na resposta
        if (data['data'] != null) {
          return data['data'];
        } else {
          throw Exception('Formato de dados inválido: "data" não encontrado.');
        }
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
      throw Exception('Erro ao fazer a requisição ou analisar a resposta');
    }
  }
}
