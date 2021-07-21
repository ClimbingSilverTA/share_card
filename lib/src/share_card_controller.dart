import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShareCardController extends ChangeNotifier {
  ShareCardController({GlobalKey? key}) : key = key ?? GlobalKey();
  final GlobalKey key;

  Future<Uint8List?> createImage() async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage();
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();
    return imageBytes;
  }
}
