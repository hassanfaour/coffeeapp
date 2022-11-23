// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:coffeeapp/app/app.dart';
import 'package:coffeeapp/image/image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders MyHomePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MyHomePage), findsOneWidget);
    });
  });
}
