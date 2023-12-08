// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:annoucement_form/constants.dart';

class DataModel {
  sendData(data, endPoint) async {
    var fullUrl = "$host/$endPoint";
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<Map<String, dynamic>> previewData(String id, String endpoint) async {
    var url = "$host/$endpoint/$id";
    final resp = await http.get(Uri.parse(url));

    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return data;
    } else {
      throw Exception("Faild to fectch data");
    }
  }
}
