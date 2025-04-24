import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 115),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.solidFolderOpen,
            size: MediaQuery.sizeOf(context).width * 0.40,
            color: Colors.amber,
          ),
          SizedBox(height: 8),
          const Text(
            "Add Notes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fredoka',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
