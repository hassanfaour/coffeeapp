import 'package:coffeeapp/model/models.dart';
import 'package:hive/hive.dart';

abstract class BaseImageRepository {
  Future<Box> openBox();
  List<ImageModel> getFavoritelist(Box box,);
  Future <void> SaveImage(Box box,ImageModel imageModel);
}