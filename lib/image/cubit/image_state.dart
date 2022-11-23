part of 'image_cubit.dart';

enum ImageStatus {initial, loading, success, failure}

class ImageState extends Equatable {
  const ImageState({
    this.status = ImageStatus.initial,
    this.image,
    this.url,
    this.imagebytes
  });

  final ImageStatus status;
  final Image? image;
  final String? url;
  final Uint8List? imagebytes;

  List<Object?> get props => [status, image,url,imagebytes];
}

