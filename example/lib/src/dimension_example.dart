import 'package:flutter/material.dart';

import 'package:intrinsic_dimension/intrinsic_dimension.dart';

import 'line_painter.dart';

class DimensionExample extends StatelessWidget {
  const DimensionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intrinsic Dimension - Dimension Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicDimension(
              builder: (context, width, height, startOffset) {
                return Row(
                  children: [
                    Container(
                      width: 2,
                      height: height,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vertical line with the same height as the widget using a Container',
                          ),
                          Text(
                            'Offset from top left corner (0, 0): $startOffset',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            IntrinsicDimension(
              builder: (context, width, height, startOffset) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomPaint(
                      key: ValueKey(width),
                      painter: LinePainter(
                        firstOffset: const Offset(0, 0),
                        secondOffset: Offset(width, 0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Horizontal line with the same width\nas the widget usign a LinePainter',
                        ),
                        Text(
                          'Offset from top left corner (0, 0):\n$startOffset',
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            IntrinsicDimension(
              builder: (context, width, height, startOffset) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      key: ValueKey(width),
                      children: [
                        CustomPaint(
                          painter: LinePainter(
                            firstOffset: const Offset(0, 0),
                            secondOffset: Offset(width, height),
                          ),
                        ),
                        CustomPaint(
                          painter: LinePainter(
                            firstOffset: Offset(width, 0),
                            secondOffset: Offset(0, height),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 100,
                      height: 100,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
