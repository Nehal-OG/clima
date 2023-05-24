import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final String url;

  Api(this.url);

  Future<dynamic> getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String body = response.body;

      return jsonDecode(body);
    } else {
      print(response.statusCode);
    }
  }
}
