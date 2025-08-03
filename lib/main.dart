import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/services/auth/auth_screen.dart';
import 'package:jspm_connect/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: const JspmConnect()));
}

class JspmConnect extends ConsumerWidget {
  const JspmConnect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: AuthScreen(),
    );
  }
}
