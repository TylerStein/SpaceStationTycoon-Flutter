import 'package:flutter/material.dart';

class ResourceDetails extends StatelessWidget {
  final String label;

  ResourceDetails({
    Key key,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).cardColor,
          child: Text(label, textAlign: TextAlign.left),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('+'), Text('-')],
        ),
      ],
    );
  }
}