import 'package:coffeeapp/favorite/favorite.dart';
import 'package:coffeeapp/imageviewer/viewer_page.dart';
import 'package:coffeeapp/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.favoriteAppBarTitle)),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context,state){

          if(state is FavoriteInitialized){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if(state is FavoriteLoadInProgress ){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if(state is FavoriteLoadSuccess){
            return GridView.builder(
              key: Key('grid_view_display'),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                itemCount: state.favoriteImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SingleImage(image: state.favoriteImages[index].image)),),
                    child: Image.memory(state.favoriteImages[index].image, fit: BoxFit.cover,),
                  );
                },
              );
          }
          /// In case something went wrong
          return Text("Something went wrong");
        },
      )
    );
  }
}



