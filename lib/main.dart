import 'package:flutter/material.dart';
import 'layar/home.dart';
import 'widgets/input.dart';
import 'package:provider/provider.dart';
import 'modul/classes.dart';
import 'layar/detail.dart';

void main() {
  runApp(GalleryApp());
}

class GalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>ImageFile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gallery App', 
        theme: ThemeData.light(),
        home: HomeGallery(),
        routes: {
          InputLayar.routeName:(ctx)=>InputLayar(),
          Detail.routeName:(ctx)=>Detail(),
        }
      ),
    );
  }
}
