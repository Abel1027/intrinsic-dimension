import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intrinsic_dimension/intrinsic_dimension.dart';

class IntrinsicDimensionExample extends StatelessWidget {
  const IntrinsicDimensionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double constHeight = 100;

    return MaterialApp(
      title: 'Intrinsic Dimension Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Intrinsic Dimension Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: IntrinsicDimension(
            builder: (context, width, height, startOffset) {
              return Row(
                children: [
                  if (height == constHeight)
                    Container(
                      key: const Key('Container'),
                      width: 2,
                      height: height,
                      color: Colors.black,
                    ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: constHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Vertical line'),
                        Text('Offset: $startOffset'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Find vertical line from container', (tester) async {
    await tester.pumpWidget(const IntrinsicDimensionExample());

    await tester.pumpAndSettle();

    final containerFinder = find.byKey(const Key('Container'));
    expect(containerFinder, findsOneWidget);
  });
}
