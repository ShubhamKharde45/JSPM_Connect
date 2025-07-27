import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/screens/create_screen.dart';
import 'package:jspm_connect/screens/home_screen.dart';
import 'package:jspm_connect/screens/profile_screen.dart';
import 'package:jspm_connect/utils/app_bottom_bar.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final List<Widget> pages = [
    HomeScreen(),
    CreateScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: AppBottomBar(
        onTap: (value) => setState(() {
          index = value;
        }),
      ),
    );
  }
}
