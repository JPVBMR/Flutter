import 'dart:io';

import 'package:uuid/uuid.dart';

final uuidObject = Uuid();

class PlaceModel {
  PlaceModel({required this.title, required this.imageFile})
      : id = uuidObject.v4();

  final String id;
  final String title;
  final File imageFile;
}
