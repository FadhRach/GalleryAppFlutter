import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class ImageModel {
  final String id;
  final String title;
  final String description;
  final String image;

  ImageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
}

class ImageFile with ChangeNotifier {
  List<ImageModel> _items = [];
  List<ImageModel> get items {
    return [..._items];
  }

  Future<void> addImagePlace(
      String title, String description, File image) async {
    final newImage = ImageModel(
        image: image.path, 
        title: title,
        id: DateTime.now().toString(),
        description: description);
    _items.add(newImage);
    notifyListeners();
    DataHelper.insert('user_image', {
      'id': newImage.id,
      'title': newImage.title,
      'image': newImage.image,
      'description': newImage.description,
    });
  }

  ImageModel findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fatchImage() async {
    final list = await DataHelper.getData('user_image');
    _items = list
        .map(
          (item) => ImageModel(
            id: item['id'],
            title: item['title'],
            image: item['image'],
            description: item['description'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
