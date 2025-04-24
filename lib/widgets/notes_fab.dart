import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteFab extends StatelessWidget {
  const NoteFab({
    required this.onPressed,
    super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        icon:const FaIcon(FontAwesomeIcons.plus),
        label: const Text('Add Notes', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side:const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
