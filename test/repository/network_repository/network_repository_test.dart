import 'dart:typed_data';

import 'package:coffeeapp/model/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/helpers.dart';


class MockNetworkModel extends Mock implements NetWorkModel{}


void main(){
  NetWorkModel workingModel =
  NetWorkModel(
    response: 200,
    image: Uint8List.fromList([10, 1])

  );

  NetWorkModel notWorkingModel =
  NetWorkModel(
    response: 400,
     image: Uint8List.fromList([1, 10])
  );

  // late MockNetworkModel networkModel;
  // setUp(() {
  //   networkModel = MockNetworkModel();
  // });

  group("Network Repository", () {


  });




}