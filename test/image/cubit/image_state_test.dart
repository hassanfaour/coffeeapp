import 'package:bloc_test/bloc_test.dart';
import 'package:coffeeapp/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:coffeeapp/image/image.dart';



void main(){
  group('Image State', () {
    const url = "testing.com/testing.jpg";
    Uint8List imagebytes = Uint8List.fromList([10, 1]);
    const status = ImageStatus.success;
    Image image = Image.memory(Uint8List.fromList([10, 1]));

    test('supports value comparison', () {
      expect(
        ImageState(
          status: ImageStatus.success,
          image: image,
          url: url,
          imagebytes: imagebytes,

        ),
        ImageState(
          status: ImageStatus.success,
          image: image,
          url: url,
          imagebytes: imagebytes,
        ),
      );
    });

  });


}