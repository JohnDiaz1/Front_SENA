import 'package:flutter/material.dart';

import '../models/add_to_list.dart';

/// Flutter code sample for [DataTable].

class Home extends StatelessWidget {
  Home({super.key});

  final notes = [
    NoteForList(
      noteID: "1",
      noteTitle: "Note 1",
      createdDate: DateTime.now(),
      listedDate: DateTime.now(),
    ),
    NoteForList(
      noteID: "2",
      noteTitle: "Note 2",
      createdDate: DateTime.now(),
      listedDate: DateTime.now(),
    ),
    NoteForList(
      noteID: "3",
      noteTitle: "Note 3",
      createdDate: DateTime.now(),
      listedDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => const Divider(
          height: 1,
          color: Colors.green,
        ),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              notes[index].noteTitle,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text('Edited on ${notes[index].listedDate}'),
          );
        },
        itemCount: notes.length,
      ),
    );
  }
}
