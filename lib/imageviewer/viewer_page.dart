import 'dart:typed_data';

import 'package:coffeeapp/l10n/l10n.dart';
import 'package:flutter/material.dart';

class SingleImage extends StatelessWidget {
  final Uint8List image;

  SingleImage({Key? key, required this.image,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.singleimageAppBarTitle),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            child: Image.memory(image),
          ),
        ),
      )
    );
  }
}