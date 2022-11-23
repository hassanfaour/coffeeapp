import 'package:coffeeapp/model/image_model/image_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  String id = "id";
  Uint8List image = Uint8List.fromList([10, 1]);
  String imageUrl = "image url";
  group('Image Model', () {
    test('supports value comparisons', () {
      expect(
         ImageModel(
          id: id,
          image: image,
          imageUrl: imageUrl,
        ),
         ImageModel(
          id: id,
          image: image,
          imageUrl: imageUrl,
        ),
      );
    });
  }
  );
}
