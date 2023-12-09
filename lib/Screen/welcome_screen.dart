// import 'package:annoucement_form/Screen/contactpage.dart';
import 'package:annoucement_form/Screen/contactpage.dart';
import 'package:annoucement_form/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:annoucement_form/widgets/custom_scaffold.dart';
import 'package:annoucement_form/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessanger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Contactpage(),
        ),
      );
    } else {
      sMessanger.showSnackBar(
        SnackBar(
          content: Text(errorModel.error ?? ""),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
            ),
            child: Row(
              children: [
                Logo(Logos.google),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Sign in with google",
                  style: TextStyle(
                    color: darkColorScheme.primary,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            onPressed: () => signInWithGoogle(ref, context),
          ),
        ),
      ),
    );
  }
}
