import 'dart:typed_data';

import 'package:equatable/equatable.dart';

///Made it equatable just for testing
class NetWorkModel extends Equatable  {
  final Uint8List? image;
  final String? url;
  final int? response;

  const NetWorkModel({this.image, this.url, this.response});

  @override
  List<Object?> get props => [image,url, response];
}
