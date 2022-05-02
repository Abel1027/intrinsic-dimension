import 'package:flutter/material.dart';

import 'src/connection_example.dart';
import 'src/dimension_example.dart';

enum ExampleType { dimension, connection }

void main() => runApp(
      const MyApp(
        exampleType: ExampleType.connection,
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.exampleType = ExampleType.dimension,
  }) : super(key: key);

  final ExampleType exampleType;

  @override
  Widget build(BuildContext context) {
    late Widget _home;

    switch (exampleType) {
      case ExampleType.connection:
        _home = const ConnectionExample();
        break;
      default:
        _home = const DimensionExample();
    }

    return MaterialApp(
      title: 'Intrinsic Dimension Example',
      debugShowCheckedModeBanner: false,
      home: _home,
    );
  }
}
