import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchContents() async {
    final response = await http.get(Uri.parse('http://localhost/Api/v1/contenido.php'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los contenidos');
    }
  }
}
