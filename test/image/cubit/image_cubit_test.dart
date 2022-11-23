import 'package:bloc_test/bloc_test.dart';
import 'package:coffeeapp/model/network_model/network_model.dart';
import 'package:coffeeapp/repository/repository.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:coffeeapp/image/image.dart';

class MockNetworkRepository extends Mock implements NetworkRepository {}
class MockNetworkModel extends Mock implements NetWorkModel{}

void main(){

  ///I realized after writing my test code
  ///That all http request will return code 400 which failure
  ///I have an null error ruing my tests

  group('Image Cubit', () {
    late MockNetworkModel netWorkModel;
    late MockNetworkRepository networkRepository;
    // const url = 'testing.com/testing.jpg';
    // final imagebytes = Uint8List.fromList([10, 1]);
    // var netWorkModel =NetWorkModel(
    //   image: imagebytes,
    //   url:url,
    //   response: 202,
    // );


    setUp(() {
      netWorkModel = MockNetworkModel();
      networkRepository = MockNetworkRepository();
      when(() => networkRepository.networkAnswer() )
          .thenAnswer((_) async => netWorkModel);
    });

    test('initial state is correct', () {
      expect(
        ImageCubit(
          networkRepository: networkRepository,
        ).state,
        equals(const ImageState()),
      );
    });

    group('fetchImage', () {
      blocTest<ImageCubit, ImageState>(
        'emits state with updated image',
        build: () => ImageCubit(
          networkRepository: networkRepository,
        ),
        act: (cubit) => cubit.fetchImageUrl(),
        expect: () => [
          const ImageState(
            status: ImageStatus.loading,
          ),
          const ImageState(
            status: ImageStatus.success,
          ),
        ],
      );

      blocTest<ImageCubit, ImageState>(
        'emits failure state when repository throws exception',
        build: () {
          ///This will push the Repository to throw an exception when Image is fetched
          ///but doesn't
          when(() => networkRepository.networkAnswer())
              .thenThrow(Exception());

          return ImageCubit(
            networkRepository: networkRepository,
          );
        },
        act: (cubit) => cubit.fetchImageUrl(),
        expect: () => [
          const ImageState(
            status: ImageStatus.loading,
          ),
          const ImageState(
            status: ImageStatus.failure,
          ),
        ],
      );
    });

  });
}
