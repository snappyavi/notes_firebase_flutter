import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({super.key, required this.child, required this.onPressed, this.label});

  final Widget child;
 final String? label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.black)],

        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        //  autofocus: true,
        child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
