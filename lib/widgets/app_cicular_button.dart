import 'package:flutter/material.dart';

class AppCircularButton extends StatelessWidget {
  const AppCircularButton({Key? key, required this.child, this.color,  this.width=60, this.onTap}) : super(key: key);
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return  Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
