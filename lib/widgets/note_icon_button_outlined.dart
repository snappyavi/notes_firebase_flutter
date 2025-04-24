
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteIconButtonOutlined extends StatelessWidget {
  const NoteIconButtonOutlined({
    required this.icon,
    required this.onPressed,
    super.key,
  });


  //to make it usable
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon),
      style: IconButton.styleFrom(
        //for background of the icon
        backgroundColor: Colors.amber,
        //this changes the icons color
        foregroundColor: Colors.white,
        //to add a border to the icon
        side: BorderSide(color: Colors.black),
        //for border
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
