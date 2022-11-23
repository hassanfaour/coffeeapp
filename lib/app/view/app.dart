// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:coffeeapp/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeeapp/repository/repository.dart';
import 'package:coffeeapp/image/image.dart';
import 'package:coffeeapp/favorite/favorite.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ImageRepository(),
          ),
          RepositoryProvider(
            create: (context) => NetworkRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [

            BlocProvider<ImageCubit>(
              lazy: false,
              create: (context) => ImageCubit(
                networkRepository: NetworkRepository(),
              )..fetchImageUrl(),
            ),

            BlocProvider<FavoriteCubit>(
              ///lazy set to false to wait to be initiated
              ///otherwise it will skip the first image
              lazy: false,
              create: (context) => FavoriteCubit(
                ///Here we are listening to Image Cubit to seperate logic from the presentation layer
                ///As well to seperate between the Image and Favorite Cubit's
                imageCubit: BlocProvider.of<ImageCubit>(context),
                imageRepository: ImageRepository(),
              )..getListImages(),
            )
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const MyHomePage(),
          ),
        ));
  }
}
