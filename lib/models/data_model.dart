// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:annoucement_form/constants.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

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

  Future<String> saveImage(Uint8List bytes) async {
    try {
      await [Permission.storage].request();

      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final name = 'screenshot_$time';
      final result = await ImageGallerySaver.saveImage(bytes, name: name);
      print("Picture captured");
      return result['filePath'];
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future shareImage(Uint8List bytes) async {
    try {
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final dir = await getApplicationDocumentsDirectory();
      await Share.shareXFiles([XFile('${dir.path}/flutter_$time.png')]);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
