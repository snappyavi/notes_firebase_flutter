import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/constants.dart';

class NoteIconButton extends StatelessWidget {
  const NoteIconButton({
    required this.icon,
    this.size,//optional
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  //can be optional
  final double? size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,

      //if is desceding is true shows arrow down otherwise arrow up
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints(),
      // to remove more padding
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      iconSize: size,
      color: gray700,
    );
  }
}
