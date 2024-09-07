import 'package:flutter/material.dart';
import 'package:gallery_app_with_sqlite/layar/home.dart';
import 'package:gallery_app_with_sqlite/modul/classes.dart';
import 'package:provider/provider.dart';
import 'package:gallery_app_with_sqlite/modul/database.dart';
import 'dart:io';

class Detail extends StatefulWidget {
  static const routeName = 'Detail';

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)!.settings.arguments as String;
    final image =
        Provider.of<ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(
        title: Text(image.title),
        backgroundColor: Color(0xff365992),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff365992),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("CONFIRM"),
                  content: Text("Apakah kamu ingin membuang foto ini?"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("No"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await DataHelper.delete('user_image', imageId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeGallery()));
                      },
                      child: Text("Yes"),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            height: 400,
            width: double.infinity,
            child: Image.file(
              File(image.image),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            image.title,
            style: TextStyle(fontSize: 30.0),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Caption : "),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              image.description,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
