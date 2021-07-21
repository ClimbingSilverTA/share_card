library share_card;

import 'dart:ui';
import 'dart:typed_data';

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

class InfoBarStyle {
  const InfoBarStyle({
    this.padding = const EdgeInsets.all(20),
    this.backgroundColor = Colors.grey,
    this.iconWidget,
  });
  final EdgeInsets padding;
  final Color backgroundColor;
  final Widget? iconWidget;
}

class ShareCard extends StatefulWidget {
  const ShareCard({
    Key? key,
    required this.child,
    required this.title,
    required this.subtitle,
    this.margin = const EdgeInsets.all(0),
    this.infoBarStyle = const InfoBarStyle(),
    this.controller,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final Widget title;
  final Widget subtitle;
  final EdgeInsets margin;
  final InfoBarStyle infoBarStyle;
  final ShareCardController? controller;
  final BorderRadius? borderRadius;

  @override
  State<StatefulWidget> createState() => _ShareCardState();
}

class _ShareCardState extends State<ShareCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
      ),
      child: RepaintBoundary(
        key: widget.controller?.key,
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
          child: Column(
            children: [
              Container(
                child: widget.child,
              ),
              Container(
                padding: widget.infoBarStyle.padding,
                width: double.infinity,
                color: widget.infoBarStyle.backgroundColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.infoBarStyle.iconWidget != null)
                      widget.infoBarStyle.iconWidget!,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.title,
                          widget.subtitle,
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
