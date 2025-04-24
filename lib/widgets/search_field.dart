
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_firebase/change_notifier/notes_provider.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        // labelText: 'Search Notes',
        hintText: 'Search Notes',
        hintStyle: TextStyle(fontSize: 14),
        prefixIcon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.amber,
          //size: 16,
        ),
        //to fill it with white color
        fillColor: Colors.white,
        filled: true,
        //slims the size of the bar
        isDense: true,

        contentPadding: EdgeInsets.zero,

        //to manipulate the icon size
        // prefixIconConstraints: BoxConstraints(
        //   minHeight: 42,
        //   minWidth: 42
        // ),

        //for giving border to the search bar
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber),
        ),

        //to enable the same property while typing
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),

      onChanged: (newValue){
context.read<NotesProvider>().searchTerm=newValue;
      },
    );
  }
}
