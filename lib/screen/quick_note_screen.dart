import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class QuickNoteScreen extends StatefulWidget {
  const QuickNoteScreen({super.key});

  @override
  State<QuickNoteScreen> createState() => _QuickNoteScreenState();
}

class _QuickNoteScreenState extends State<QuickNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final List<String> notes = [];
  int? editIndex;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get _localFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    final subDir = Directory('${directory.path}/QuickNote');

    // Create the subdirectory if it doesn't exist
    if (!await subDir.exists()) {
      await subDir.create(recursive: true);
    }

    final filePath = '${subDir.path}/notes.txt';

    debugPrint('Notes file path: $filePath');

    return filePath;
  }

  // Save notes to a file
  Future<void> _saveNotes() async {
    final file = await _localFilePath;
    final notesString = notes.join('\n');
    await File(file).writeAsString(notesString);
  }

  // Get notes from a file
  Future<List<String>> _getNotes() async {
    final file = await _localFilePath;
    if (await File(file).exists()) {
      final contents = await File(file).readAsString();
      return contents.split('\n');
    } else {
      return [];
    }
  }

  // Load notes from the file
  Future<void> _loadNotes() async {
    final loadedNotes = await _getNotes();
    setState(() {
      notes.clear();
      notes.addAll(loadedNotes);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _localFilePath.then((path) => debugPrint('Notes file path: $path'));
  }

  // Edit note
  void _editNote(int index) {
    setState(() {
      titleController.text = notes[index];
      editIndex = index;
    });
  }

  // Delete note
  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
      _saveNotes();
    });
  }

  //Delete all notes
  void _deleteAllNotes() {
    setState(() {
      notes.clear();
      _saveNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('QuickNote CRUD', style: TextStyle(fontSize: 20))),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('All Notes Deleted'),
                    content:
                        const Text('All notes have been successfully deleted.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _deleteAllNotes();
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signUp');
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Enter note',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 43, 42, 42),
                  ),
                  onPressed: () {
                    final text = titleController.text.trim();
                    if (text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter some text')),
                      );
                      return; // Don't add or update
                    }

                    setState(() {
                      if (editIndex != null) {
                        notes[editIndex!] = text;
                        editIndex = null;
                      } else {
                        notes.add(text);
                      }
                      titleController.clear();
                      _saveNotes();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note added/updated')),
                      );
                    });
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: notes.isEmpty
                  ? const Center(child: Text('No notes available'))
                  : ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: ListTile(
                              title: Text(notes[index]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _editNote(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Delete Note'),
                                            content: const Text(
                                                'Are you sure you want to delete this note?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  _deleteNote(index);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Delete',
                                                    style: TextStyle(
                                                        color: Colors.red)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
