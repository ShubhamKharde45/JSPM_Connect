import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key, required this.onTap});

  final void Function(int) onTap;
  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      iconSize: 25,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,

      selectedFontSize: 18,
      unselectedFontSize: 15,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      onTap: (value) {
        widget.onTap(value);
        setState(() {
          currentIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: "Home",
          backgroundColor: Colors.transparent,
        ),

        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.add),
          label: "Create",
          backgroundColor: Colors.transparent,
        ),

        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.bell),
          label: "Notifications",
          backgroundColor: Colors.transparent,
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: "Profile",
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
