import 'package:hive/hive.dart';
import 'package:coffeeapp/model/models.dart';

import 'base_image_repository.dart';

class ImageRepository extends BaseImageRepository{
  String boxName = 'image_repository';
  Type boxType = ImageModel;
  Box? currentBox;

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<ImageModel>(boxName);
    currentBox = box;
    return box;
  }

  @override
  List<ImageModel> getFavoritelist(Box box) {
    return box.values.toList() as List<ImageModel>;
  }

  @override
  Future<void> SaveImage(Box box, ImageModel imageModel) async {
    await box.put(imageModel.id, imageModel);
  }
}