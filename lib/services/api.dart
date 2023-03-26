import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../helpers/const.dart';

class Api {
  Future<Response> get(url, Map body) async {
    Response response = await http.get(Uri.parse("$baseUrl$url"));
    return response;
  }

  Future<Response> post(url, Map body) async {
    Response response = await http.post(Uri.parse("$baseUrl$url"), body: body);
    return response;
  }

  Future<Response> put(url, Map body) async {
    Response response = await http.put(Uri.parse('$baseUrl$url'), body: body);
    return response;
  }

  delete(url, Map body) async {
    Response response =
        await http.delete(Uri.parse('$baseUrl$url'), body: body);
    return response;
  }
}
