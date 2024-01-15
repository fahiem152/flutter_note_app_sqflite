import 'package:flutter/material.dart';
import 'package:note_app_sqflite/data/datasource/local_datasource.dart';
import 'package:note_app_sqflite/data/model/note.dart';
import 'package:note_app_sqflite/pages/edit_page.dart';
import 'package:note_app_sqflite/pages/home_pages.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Detail Note',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Note'),
                        content: const Text('Are you sure?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                await LocalDatasource()
                                    .deleteNoteById(widget.note.id!);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage();
                                }));
                              },
                              child: const Text('Delete')),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.note.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            widget.note.content,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPage(
              note: widget.note,
            );
          }));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
