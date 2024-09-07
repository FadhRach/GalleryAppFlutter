import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery_app_with_sqlite/widgets/input.dart';
import 'package:provider/provider.dart';
import 'package:gallery_app_with_sqlite/modul/classes.dart' as ima;
import 'dart:io';
import 'detail.dart';

class HomeGallery extends StatefulWidget {
  const HomeGallery({super.key});

  @override
  State<HomeGallery> createState() => _HomeGalleryState();
}

class _HomeGalleryState extends State<HomeGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery App'),
        backgroundColor: Color(0xff365992),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff365992),
        onPressed: () {
          Navigator.pushNamed(context, InputLayar.routeName);
        },
        child: Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<ima.ImageFile>(context, listen: false).fatchImage(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<ima.ImageFile>(
              child: Center(child: Text('Start Add Your Gallery')),
              builder: (ctx, image, ch) => image.items.isEmpty
                  ? Center(
                      child: ch,
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: image.items.length,
                      itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GridTile(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Detail.routeName,
                                  arguments: image.items[i].id,
                                );
                              },
                              child: Image.file(
                                File(image.items[i].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          footer: GridTileBar(
                            title: Text(' '),
                            subtitle: Text(image.items[i].id),
                          ),
                        ),
                      ),
                    ),
            );
          }
        },
      ),
    );
  }
}
