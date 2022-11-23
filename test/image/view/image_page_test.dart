import 'package:bloc_test/bloc_test.dart';
import 'package:coffeeapp/app/app.dart';
import 'package:coffeeapp/favorite/favorite.dart';
import 'package:coffeeapp/model/models.dart';
import 'package:coffeeapp/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:coffeeapp/image/image.dart';

import '../../helpers/helpers.dart';

class MockNetworkRepository extends Mock implements NetworkRepository {}
class MockImageCubit extends MockCubit<ImageState> implements ImageCubit{}
class MockNetworkModel extends Mock implements NetWorkModel{}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main(){
  late MockNetworkModel networkModel;
  group('Image Page', () {
    late MockNetworkRepository networkRepository;
    setUp(() {
      networkRepository = MockNetworkRepository();
      networkModel = MockNetworkModel();
      when(() => networkRepository.networkAnswer() ).thenAnswer((_) async => networkModel);
    });

    testWidgets('renders ImageBuild', (tester) async {
      await tester.pumpApp(App());
      expect(find.byType(ImageBuild), findsOneWidget);
    });
  });

  group('Image View', () {
    late MockImageCubit imageCubit;
    late NetworkRepository networkRepository;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      networkRepository = MockNetworkRepository();
      imageCubit = MockImageCubit();
      mockNavigatorObserver = MockNavigatorObserver();
    });
    setUpAll(() {
      registerFallbackValue(const ImageState());
    });


    testWidgets('Testing refresh button by icon', (tester) async {
      await tester.pumpApp(App());
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      await tester.tap(find.byIcon(Icons.refresh).first);
      expect(CircularProgressIndicator, findsOneWidget);
      expect(Image, findsOneWidget);
    });
    testWidgets('Testing like button by icon', (tester) async {
      await tester.pumpApp(App());
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite).first);
      expect(CircularProgressIndicator, findsOneWidget);
      expect(Image, findsOneWidget);
      // expect(imageCubit.state.status == ImageStatus.loading, findsOneWidget);

    });
    testWidgets('Testing View Favorite button by Text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: App(),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );
      expect(find.byKey(Key('view_favorite_button')), findsOneWidget);
      await tester.tap(find.byKey(Key('view_favorite_button')).first);
      await tester.pumpAndSettle();
      // verify(mockNavigatorObserver.didPush(any(), any()));
      expect(find.byType(FavoritePage), findsOneWidget);

    });
    testWidgets('Testing refresh button by key', (tester) async {
      await tester.pumpApp(App());
      expect(find.byKey(Key('refresh_image_button')), findsOneWidget);
      await tester.tap(find.byKey(Key('refresh_image_button')).first);
      expect(CircularProgressIndicator, findsOneWidget);
      expect(Image, findsOneWidget);
    });
    testWidgets('Testing like button by key', (tester) async {
      await tester.pumpApp(App());
      expect(find.byKey(Key('add_to_favorite_button')), findsOneWidget);
      await tester.tap(find.byKey(Key('add_to_favorite_button')).first);
      expect(CircularProgressIndicator, findsOneWidget);
      expect(Image, findsOneWidget);
    });

    group("Status rendering", () {


    testWidgets('renders empty page when status is initial', (tester) async {
      const key = Key('imageView_initial_sizedBox');

      when(() => imageCubit.state).thenReturn(
        const ImageState(),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: imageCubit,
          child: const ImageBuild(),
        ),
      );

      expect(find.byKey(key), findsNothing);
    });


    testWidgets(
      'renders loading indicator when status is loading',
          (tester) async {
        const key = Key('imageView_loading_indicator');
        when(() => imageCubit.state).thenReturn(
          const ImageState(
            status: ImageStatus.loading,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: imageCubit,
            child: const ImageBuild(),
          ),
        );
        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders error text when status is failure',
          (tester) async {
        const key = Key('imageView_failure_text');

        when(() => imageCubit.state).thenReturn(
          const ImageState(
            status: ImageStatus.failure,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: imageCubit,
            child: const ImageBuild(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders image when status is success',
          (tester) async {
        const key = Key('imageView_success_image');
        when(() => imageCubit.state).thenReturn(
          ImageState(
            status: ImageStatus.success,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: imageCubit,
            child: const ImageBuild(),
          ),
        );
        expect(find.byKey(key), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      },
    );
    });

  });

  group("Search", ()  {
    testWidgets("Search by Icon", (tester) async {
      await tester.pumpWidget(const MyHomePage());
      expect(find.widgetWithIcon(FloatingActionButton, Icons.refresh), findsOneWidget);
      expect(find.widgetWithIcon(FloatingActionButton, Icons.favorite), findsOneWidget);
    });

    testWidgets("Reload by Key", (tester) async {
      await tester.pumpWidget(const MyHomePage());
      expect(find.byKey(Key('refresh_image_button')), findsOneWidget);
    });

    testWidgets("View Favorite by Key", (tester) async {
      await tester.pumpWidget(const MyHomePage());
      expect(find.byKey(Key('view_favorite_button')), findsOneWidget);
    });

    testWidgets("Like by Key", (tester) async {
      await tester.pumpWidget(const MyHomePage());
      expect(find.byKey(Key('add_to_favorite_button')), findsOneWidget);
    });
  });
}