import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:coffeeapp/model/models.dart';
import 'package:coffeeapp/image/image.dart';
import 'package:coffeeapp/repository/repository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final ImageRepository imageRepository;
  final ImageCubit imageCubit;
  StreamSubscription? imageSubscription;
  ///Bellow will be reset everytime the image change
  ///
  String? currenturl;
  Image? currentImage;
  ImageStatus? currentStatus;
  Uint8List? currentImageBytes;



  FavoriteCubit({
    required this.imageCubit,
    required ImageRepository imageRepository
  }) : imageRepository = imageRepository,
  super(FavoriteInitialized())
  {
      imageSubscription = imageCubit.stream.listen((ImageState imageState) {
      currenturl = imageState.url;
      currentImage = imageState.image;
      currentStatus = imageState.status;
      currentImageBytes = imageState.imagebytes;

    });
  }

  ///Decided to put the save function here to separate logic
  void saveImage()async{
    emit(FavoriteLoadInProgress());

    String currenttime = DateTime.now().millisecondsSinceEpoch.toString();
    if(currentStatus == ImageStatus.success){
      try{
        Box box = await imageRepository.openBox();
        imageRepository.SaveImage(
            box,
            ImageModel(id: currenttime, image: currentImageBytes!, imageUrl: currenturl!));
        getListImages();
        ///No need to add Favorite Load Success
        ///Because the first thing emit Favorite Load in progress
      }
      on Exception {
        ///Should show a toast on the screen
        emit(FavoriteLoadFailure());
      }
    }
  }

  void getListImages()async{
    emit(FavoriteLoadInProgress());
    try{
      Box box = await imageRepository.openBox();
      List<ImageModel> favoriteImages = imageRepository.getFavoritelist(box);
      emit(
        FavoriteLoadSuccess(favoriteImages)
      );
    }
    on Exception {
      emit(FavoriteLoadFailure());
    }
  }

  @override
  Future<void> close() {
    imageSubscription?.cancel();
    return super.close();
  }
}
