import 'package:annoucement_form/Screen/contactpage.dart';
import 'package:annoucement_form/models/error_model.dart';
import 'package:annoucement_form/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:annoucement_form/Screen/welcome_screen.dart';
import 'package:annoucement_form/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  ErrorModel? errorModel;

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();

    if (errorModel != null && errorModel!.data != null) {
      EasyLoading.show(status: 'loading...');
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: user == null ? const WelcomeScreen() : const Contactpage(),
      builder: EasyLoading.init(),
    );
  }
}
