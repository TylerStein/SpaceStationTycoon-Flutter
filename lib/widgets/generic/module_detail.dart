import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModuleDetail extends StatelessWidget {
  final Widget child;
  
  ModuleDetail({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6.0, offset: Offset(0, -6)),
        ]
      ),
      child: child,
    );
  }
}