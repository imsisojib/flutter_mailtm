import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlViewer extends StatefulWidget{
  final String? description;

  const HtmlViewer({Key? key, this.description,}) : super(key: key);

  @override
  State<HtmlViewer> createState() => _HtmlViewerState();
}

class _HtmlViewerState extends State<HtmlViewer> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Html(
      shrinkWrap: true,
      data: widget.description ?? '',
      style: {
        "p": Style(
          color: theme.textTheme.bodyText1?.color,
          fontSize: FontSize(14),
          padding: EdgeInsets.zero,
          lineHeight: LineHeight(1.3),
        ),
        "*": Style(
          color: theme.textTheme.bodyText1?.color,
          fontSize: FontSize(14),
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
        ),
        "b": Style(
          color: theme.textTheme.bodyText1?.color,
          fontSize: FontSize(13),
          fontWeight: FontWeight.bold,
          lineHeight: LineHeight(1.3),
        ),
      },
      onAnchorTap: (link, _, map, element) async{

      },
    );
  }
}