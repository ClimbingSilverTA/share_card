import 'package:flutter/material.dart';
import 'package:share_card/src/share_card_controller.dart';

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
  BorderRadius get borderRadius =>
      widget.borderRadius ?? BorderRadius.circular(20);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: RepaintBoundary(
          key: widget.controller?.key,
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
