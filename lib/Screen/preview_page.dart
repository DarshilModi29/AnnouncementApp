import 'package:flutter/material.dart';
import 'package:annoucement_form/models/data_model.dart';
// import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:screenshot/screenshot.dart';

class PreviewPage extends StatefulWidget {
  final String id;
  const PreviewPage({super.key, required this.id});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late Future<Map<String, dynamic>> previewData;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    previewData = DataModel().previewData(widget.id, "data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Preview",
          style: TextStyle(fontSize: 30),
        ),
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
              child: Container(
                color: Colors.white,
                child: Screenshot(
                  controller: screenshotController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      buildInfoRow(
                          "Description", data['picdata']['description']!),
                      buildInfoRow("Position", data['picdata']['position']!),
                      buildInfoRow(
                          "Requirements", data['picdata']['requirement']!),
                      buildInfoRow(
                          "Salary Approx", data['picdata']['sapprox']!),
                      buildInfoRow("Address", data['picdata']['address']!),
                      buildInfoRow("Contact", data['picdata']['contacts']!),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 1));
                final image = await screenshotController.capture();

                if (image == null) return;

                await DataModel().saveImage(image);
              },
              child: const Icon(Icons.save),
            ),
            ElevatedButton(
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 1));
                final image = await screenshotController.capture();

                await DataModel().shareImage(image!);
              },
              child: const Icon(Icons.share),
            ),
          ],
        )
      ],
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
