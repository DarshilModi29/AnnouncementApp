// import 'dart:convert';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:annoucement_form/models/data_model.dart';
// import 'package:flutter/rendering.dart';
import 'dart:async';
// import 'dart:ui' as ui;

class PreviewPage extends StatefulWidget {
  final String id;

  const PreviewPage({Key? key, required this.id}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late Future<Map<String, dynamic>> previewData;
  // GlobalKey _globalKey = GlobalKey();

// Future<Uint8List?> _capturePng() async {
//   try {
//     print('inside');
//     RenderRepaintBoundary boundary =
//         _globalKey.currentContext.findRenderObject();
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData byteData =
//         await image.toByteData(format: ui.ImageByteFormat.png);
//     var pngBytes = byteData.buffer.asUint8List();
//     var bs64 = base64Encode(pngBytes);
//     print(pngBytes);
//     print(bs64);
//     setState(() {});
//     return pngBytes;
//   } catch (e) {
//     print(e);
//   }
// }

  @override
  void initState() {
    super.initState();
    previewData = DataModel().previewData(widget.id, "data");
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // key: _globalKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Preview",
            style: TextStyle(fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {},
          tooltip: "Save to image",
          child: const Icon(Icons.save),
        ),
        body: FutureBuilder(
          future: previewData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    buildInfoRow(
                        "Description", data['picdata']['description']!),
                    buildInfoRow("Position", data['picdata']['position']!),
                    buildInfoRow(
                        "Requirements", data['picdata']['requirement']!),
                    buildInfoRow("Salary Approx", data['picdata']['sapprox']!),
                    buildInfoRow("Address", data['picdata']['address']!),
                    buildInfoRow("Contact", data['picdata']['contacts']!),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
