import 'package:coffeeapp/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Uint8List image = Uint8List.fromList([10, 1]);
  String url = "url";
  int response = 10;
  group('Network Model', () {
    test('supports value comparisons', () {
      expect(
        NetWorkModel(
          image: image,
          url: url,
          response: response,
        ),
        NetWorkModel(
          image: image,
          url: url,
          response: response,
        ),
      );
    });
  }
  );
}
