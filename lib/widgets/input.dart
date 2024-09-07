import 'package:flutter/material.dart';
import 'package:gallery_app_with_sqlite/widgets/imageinput.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:gallery_app_with_sqlite/modul/classes.dart';

class InputLayar extends StatefulWidget {
  const InputLayar({super.key});
  static const routeName = 'InputLayar';
  @override
  State<InputLayar> createState() => _InputLayarState();
}

class _InputLayarState extends State<InputLayar> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  File? savedImage;

  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        savedImage == null) {
      ///////
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false)
          .addImagePlace(_titleController.text, _descController.text, savedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Image'),
        backgroundColor: Color(0xff365992),
        actions: [
          IconButton(onPressed: onSave, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ImageInput(savedImages),
              ],
            ),
          )),
    );
  }
}
