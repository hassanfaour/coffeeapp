import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffeeapp/model/image_model/image_model.dart';
import 'package:coffeeapp/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coffeeapp/favorite/favorite.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../helpers/helpers.dart';

class MockFavoriteCubit extends MockCubit<FavoriteState> implements FavoriteCubit{}
class MockImageRepository extends Mock implements ImageRepository{}
class MockImageModel extends Mock implements ImageModel{}

void main(){


  group('Favorite Page', () {

    testWidgets('renders Favorite Page', (tester) async {
      await tester.pumpApp(FavoritePage());
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders Title correctly', (tester) async {
      await tester.pumpApp(FavoritePage());
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('Make sure State is correct', (tester) async {
      await tester.pumpApp(FavoritePage());
      final BuildContext favoriteViewContext =
      tester.element(find.byType(GridView));
      expect(
        favoriteViewContext.read<FavoriteCubit>().state,
        equals(FavoriteState),
      );

    });

    testWidgets('renders GridView Correctly', (tester) async {
      await tester.pumpApp(FavoritePage());
      expect(find.byKey(Key('grid_view_display')), findsOneWidget);
    });




    late MockFavoriteCubit favoriteCubit;
    late MockImageRepository imageRepository;
    late MockImageModel imageModel;
    List<ImageModel>? testingList;

    setUp(() {
      favoriteCubit = MockFavoriteCubit();
      imageRepository = MockImageRepository();
      imageModel = MockImageModel();
      for(int i = 0; i<10; i++){
        testingList?.add(MockImageModel());
      }
      // when;
    });

    // testWidgets(
    //   "App bar widget test",
    //       (tester) async {
    //     await tester.pumpWidget(FavoritePage());
    //     expect(find.text((await GlobalMaterialLocalizations.)), findsOneWidget);
    //   },
    // );

    // blocTest<FavoriteCubit, FavoriteState> (
    //     'Favorite getList test',
    //     build: ()=> favoriteCubit,
    //     act: (bloc) async {
    //       bloc.getListImages();
    //     },
    //     expect: ()=>[
    //       FavoriteLoadInProgress(),
    //       FavoriteLoadSuccess(),
    //     ]
    // );

  });
}