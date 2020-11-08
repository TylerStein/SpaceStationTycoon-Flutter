import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget{
  final Widget child;
  final bool isLoading;

  LoadingOverlay({
    @required this.child,
    @required this.isLoading,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: child,
        ),
        Visibility(
          visible: isLoading == true,
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text('Loading assets', style: Theme.of(context).textTheme.headline4),
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}