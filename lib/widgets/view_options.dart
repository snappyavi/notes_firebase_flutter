import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_firebase/change_notifier/notes_provider.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';
import 'note_icon_button.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder:
          (_, notesProvider, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              children: [
                NoteIconButton(
                  icon:
                      notesProvider.isDescending
                          ? FontAwesomeIcons.arrowDown
                          : FontAwesomeIcons.arrowUp,
                  size: 18,
                  onPressed: () {
                    setState(() {
                      notesProvider.isDescending = !notesProvider.isDescending;
                    });
                  },
                ),
                //space b/w them
                SizedBox(width: 16),

                DropdownButton(
                  value: notesProvider.orderBy,

                  icon: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: FaIcon(
                      FontAwesomeIcons.arrowDownWideShort,
                      size: 18,
                      color: gray700,
                    ),
                  ),
                  //removes underline
                  underline: SizedBox.shrink(),

                  //to remove the space
                  isDense: true,
                  //adds a circular edge to drop down page
                  borderRadius: BorderRadius.circular(16),
                  items:
                      OrderOption.values
                          .map(
                            (e) => DropdownMenuItem(
                              //to mention the name
                              value: e,
                              child: Row(
                                children: [
                                  Text(e.name),

                                  //implementing check logic for the dropdown menu
                                  if (e == notesProvider.orderBy) ...[
                                    SizedBox(width: 8),
                                    Icon(Icons.check),
                                  ],
                                ],
                              ),
                            ),
                          )
                          .toList(),
                  //does not show the check icon in the row, only when tapped
                  selectedItemBuilder:
                      (context) =>
                          OrderOption.values.map((e) =>
                              //enum name=e.name
                              Text(e.name)).toList(),

                  onChanged: (newValue) {
                    //renames the value to selected value
                    //set state helps in seting a new state or changing the state
                    setState(() {
                      notesProvider.orderBy = newValue!;
                    });
                  },
                ),
                const Spacer(),
                //   SizedBox(width: 30,),

                //this helps change the layout when needed
                NoteIconButton(
                  icon:
                      notesProvider.isGrid
                          ? FontAwesomeIcons.tableCellsLarge
                          : FontAwesomeIcons.bars,
                  size: 18,
                  onPressed: () {
                    setState(() {
                      notesProvider.isGrid = !notesProvider.isGrid;
                    });
                  },
                ),
              ],
            ),
          ),
    );
  }
}
