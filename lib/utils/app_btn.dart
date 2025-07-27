import 'package:flutter/material.dart';

class AppBtn extends StatefulWidget {
  const AppBtn({
    super.key,
    required this.height,
    required this.width,
    this.child,
    this.onTap,
  });

  final double height;
  final double width;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  State<AppBtn> createState() => _AppBtnState();
}

class _AppBtnState extends State<AppBtn> {
  double scale = 1;

  void _popEffect() async {
    setState(() => scale = 0.9);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => scale = 1.0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _popEffect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(scale),
        transformAlignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}