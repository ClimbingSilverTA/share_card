library share_card;

import 'package:flutter/material.dart';

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

class ShareCard extends StatelessWidget {
  const ShareCard({
    Key? key,
    required this.child,
    required this.title,
    required this.subtitle,
    this.margin = const EdgeInsets.all(0),
    this.infoBarStyle = const InfoBarStyle(),
    this.borderRadius,
  }) : super(key: key);
  final Widget child;
  final Widget title;
  final Widget subtitle;
  final EdgeInsets margin;
  final InfoBarStyle infoBarStyle;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              child: child,
            ),
            Container(
              padding: infoBarStyle.padding,
              width: double.infinity,
              color: infoBarStyle.backgroundColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (infoBarStyle.iconWidget != null) infoBarStyle.iconWidget!,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [title, subtitle],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
