import 'package:flutter/material.dart';
import 'package:note_app_sqflite/data/model/note.dart';
import 'package:note_app_sqflite/pages/home_pages.dart';

import '../data/datasource/local_datasource.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Content wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Note note = Note(
                id: widget.note.id,
                title: titleController.text,
                content: contentController.text,
                createdAt: DateTime.now());

            LocalDatasource().updateNoteById(note);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
              (Route<dynamic> route) =>
                  false, // Hapus semua halaman dari tumpukan
            );
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
