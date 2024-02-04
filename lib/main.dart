import 'package:flutter/material.dart';
import 'package:note_function/view/calender_page.dart';

void main()
{
  runApp(const NoteFunction());
}

class NoteFunction extends StatefulWidget {
  const NoteFunction({super.key});

  @override
  State<NoteFunction> createState() => _NoteFunction();
}

class _NoteFunction extends State<NoteFunction>
{
  @override
  Widget build(BuildContext context)
  {
    return const MaterialApp
        (
          home: CalenderPage(),
        );
  }
}
