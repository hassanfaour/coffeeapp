import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final Uint8List image;

  @HiveField(2)
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.image,
    required this.imageUrl,
  });

  ImageModel copyWith({
    String? id,
    Uint8List? image,
    String? imageUrl,
  }) {
    return ImageModel(
      id: id ?? this.id,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, image, imageUrl];
}