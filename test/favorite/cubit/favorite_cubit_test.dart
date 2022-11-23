import 'package:bloc_test/bloc_test.dart';
import 'package:coffeeapp/image/image.dart';
import 'package:coffeeapp/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:coffeeapp/favorite/favorite.dart';

class MockImageRepository extends Mock implements ImageRepository{}
class MockImageCubit extends MockCubit<ImageState> implements ImageCubit{}
class MockImageState extends Mock implements ImageState{}

void main(){
  group('Favorite Cubit', () {

    late MockImageRepository imageRepository;
    late MockImageCubit imageCubit;
    late MockImageState imageState;

    setUp(() {
      imageRepository = MockImageRepository();
      imageCubit = MockImageCubit();
      imageState = MockImageState();
    });

    test('initial state is HomeState', () {
      expect(FavoriteCubit(imageCubit: imageCubit,imageRepository: imageRepository).state,
          equals(FavoriteInitialized));
    });

    blocTest<FavoriteCubit, FavoriteState> (
      'Favorite getList test',
      build: ()=> FavoriteCubit(imageCubit: imageCubit, imageRepository: imageRepository),
      act: (bloc) async =>  bloc.getListImages(),
      expect: ()=>[
        FavoriteLoadInProgress(),
        FavoriteLoadSuccess(),
      ]
    );

    blocTest<FavoriteCubit, FavoriteState> (
        'Save Image test',
        build: ()=> FavoriteCubit(imageCubit: imageCubit, imageRepository: imageRepository),
        act: (bloc) async =>  bloc.saveImage(),
        expect: ()=>[
          FavoriteLoadInProgress(),
          ///Because getList is called right after
          ///it could also give
          ///FavoriteLoadFailure()
          FavoriteLoadInProgress(),
          FavoriteLoadSuccess(),
        ]
    );




    blocTest<FavoriteCubit, FavoriteState>(
        'Favorite Load in Progress',
        build: ()=>FavoriteCubit(imageCubit: imageCubit, imageRepository: imageRepository),
        act: (bloc) => bloc.emit(FavoriteLoadInProgress()),
        expect: ()=>[
          FavoriteLoadInProgress(),
        ]
    );

    blocTest<FavoriteCubit, FavoriteState>(
        'Favorite Load Success',
        build: ()=>FavoriteCubit(imageCubit: imageCubit, imageRepository: imageRepository),
        act: (bloc) => bloc.emit(FavoriteLoadSuccess()),
        expect: ()=>[
          FavoriteLoadSuccess(),
        ]
    );
    blocTest<FavoriteCubit, FavoriteState>(
        'Favorite Load Failure',
        build: ()=>FavoriteCubit(imageCubit: imageCubit, imageRepository: imageRepository),
        act: (bloc) => bloc.emit(FavoriteLoadFailure()),
        expect: ()=>[
          FavoriteLoadFailure(),
        ]
    );

  });
}