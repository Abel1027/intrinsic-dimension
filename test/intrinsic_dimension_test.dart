import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intrinsic_dimension/intrinsic_dimension.dart';

class IntrinsicDimensionExample extends StatelessWidget {
  const IntrinsicDimensionExample({
    Key? key,
    required this.rebuild,
  }) : super(key: key);

  final bool rebuild;

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
            rebuild: rebuild,
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Find vertical line from container - No rebuild', (tester) async {
    await tester.pumpWidget(const IntrinsicDimensionExample(rebuild: false));

    await tester.pumpAndSettle();

    final containerFinder = find.byKey(const Key('Container'));
    expect(containerFinder, findsOneWidget);
  });

  testWidgets('Find vertical line from container - Rebuild', (tester) async {
    await tester.pumpWidget(const IntrinsicDimensionExample(rebuild: true));

    await tester.pump();

    final containerFinder = find.byKey(const Key('Container'));
    expect(containerFinder, findsOneWidget);
  });
}
