import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:coffeeapp/model/models.dart';
import 'package:coffeeapp/repository/repository.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState>{
  final NetworkRepository networkRepository;

  ImageCubit({
    required NetworkRepository networkRepository,
  }) : networkRepository = networkRepository,
        super(ImageState());

  Future<void> fetchImageUrl() async {
    emit(ImageState(status: ImageStatus.loading));

    NetWorkModel netWorkModel = await networkRepository.networkAnswer();

    if(netWorkModel.response == 200){
      emit(ImageState(
        status: ImageStatus.success,
        image: Image.memory(netWorkModel.image!),
        url: netWorkModel.url,
        imagebytes: netWorkModel.image
      ));
    } else emit(ImageState(status: ImageStatus.failure));
  }
}



