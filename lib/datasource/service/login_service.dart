import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  Future<String> login(String userName, String password) async {
    final url = Uri.parse(
        'https://chaauthenticationdelegateservice.azurewebsites.net/api/login');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(<String, String>{
          "username": userName,
          "password": password,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'error';
    }
  }
}
