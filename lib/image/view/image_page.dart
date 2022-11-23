// import 'dart:html';

// import 'package:coffeeapp/favorite/cubit/favorite_cubit.dart';
// import 'package:coffeeapp/favorite/view/favorite_page.dart';
import 'package:coffeeapp/favorite/favorite.dart';
import 'package:coffeeapp/image/image.dart';
import 'package:coffeeapp/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text(l10n.coffeeAppBarTitle)),
        body: Center(
          child: Stack(
            children: [
              ImageBuild(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                key: Key('refresh_image_button'),
                backgroundColor: Colors.grey,
                heroTag: null,
                onPressed: () => context.read<ImageCubit>().fetchImageUrl(),
                child: const Icon(Icons.refresh),
              ),
            ),

            FloatingActionButton.extended(
              key: Key('view_favorite_button'),
              backgroundColor: Colors.black,
              label: Text(l10n.viewFavoriteTitle),
              heroTag: null,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              ),
            ),
            Padding(
              key: Key('add_to_favorite_button'),
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                heroTag: null,
                onPressed: () {
                  context.read<FavoriteCubit>().saveImage();
                  context.read<ImageCubit>().fetchImageUrl();
                },
                child: const Icon(Icons.favorite),
              ),
            ),
          ],
        )
    );
  }
}

class ImageBuild extends StatelessWidget {
  const ImageBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((ImageCubit cubit) => cubit.state.status);
    final imagefetched = context.select((ImageCubit cubit) => cubit.state.image);

    switch (status) {
      case ImageStatus.initial:
        return const SizedBox(
          key: Key('imageView_initial_sizedBox'),
        );
      case ImageStatus.loading:
        return const Center(
          key: Key('imageView_loading_indicator'),
          child: CircularProgressIndicator.adaptive(),
        );
      case ImageStatus.failure:
        return Center(
          key: const Key('imageView_failure_text'),
          child: Text('Something went wrong'),
        );
      case ImageStatus.success:
        return Center(
          key: const Key('imageView_success_image'),
            child: imagefetched
        );
    }
  }
}
