import 'package:flutter/material.dart';

/// {@template NotFoundView.class}
/// NotFoundView widget.
/// {@endtemplate}
class NotFoundView extends StatelessWidget {
  /// {@macro NotFoundView.class}
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('404'));
  }
}
