// import 'package:annoucement_form/Screen/preview_page.dart';
import 'package:flutter/material.dart';
// import 'package:annoucement_form/Screen/welcome_screen.dart';
import 'package:annoucement_form/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:annoucement_form/Screen/contactpage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const Contactpage(),
      builder: EasyLoading.init(),
    );
  }
}
