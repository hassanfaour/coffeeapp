import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:coffeeapp/favorite/favorite.dart';

// final ImageStatus status;
// final Image? image;
// final String? url;
// final Uint8List? imagebytes;

void main(){
  group('Favorite State', () {
    test('Supports value comparison', () => {
      expect(
        const FavoriteState(),
        const FavoriteState()
      )
    }
    );
    test('can be instantiated', () {
      expect(FavoriteLoadInProgress(), isNotNull);
    });

    test('supports value equality', () {
      expect(
        FavoriteInitialized(),
        equals(FavoriteInitialized()),
      );
    });

    test('supports value equality', () {
      expect(
        FavoriteLoadInProgress(),
        equals(FavoriteLoadInProgress()),
      );
    });

    test('supports value equality', () {
      expect(
        FavoriteLoadSuccess(),
        equals(FavoriteLoadSuccess()),
      );
    });
    test('supports value equality', () {
      expect(
        FavoriteLoadFailure(),
        equals(FavoriteLoadFailure()),
      );
    });


  });


}
