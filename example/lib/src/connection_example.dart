import 'package:flutter/material.dart';

import 'package:intrinsic_dimension/intrinsic_dimension.dart';

import 'line_painter.dart';

class ConnectionExample extends StatefulWidget {
  const ConnectionExample({Key? key}) : super(key: key);

  @override
  State<ConnectionExample> createState() => _ConnectionExampleState();
}

class _ConnectionExampleState extends State<ConnectionExample> {
  late Offset _topWidgetOffset;
  late Offset _bottomWidgetOffset;

  @override
  void initState() {
    _topWidgetOffset = Offset.zero;
    _bottomWidgetOffset = Offset.zero;
    super.initState();
  }

  Offset _updateOffset(BuildContext context, Offset offset, double topHeight) {
    return Offset(
      offset.dx,
      offset.dy - topHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intrinsic Dimension - Connection Example'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          IntrinsicDimension(
            builder: (_, __, ___, columnOffset) => Column(
              children: [
                IntrinsicDimension(
                  listener: (_, __, ___, offset) {
                    setState(() {
                      _topWidgetOffset = _updateOffset(
                        context,
                        offset,
                        columnOffset.dy,
                      );
                    });
                  },
                  builder: (_, __, ___, ____) => Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.orange,
                    child: const Text('TOP WIDGET'),
                  ),
                  rebuild: true,
                ),
                const SizedBox(height: 32),
                IntrinsicDimension(
                  listener: (_, __, ___, offset) {
                    setState(() {
                      _bottomWidgetOffset = _updateOffset(
                        context,
                        offset,
                        columnOffset.dy,
                      );
                    });
                  },
                  builder: (_, __, ___, ____) => Container(
                    color: Colors.purple,
                    child: const Text(
                      'BOTTOM WIDGET',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  rebuild: true,
                ),
              ],
            ),
          ),
          CustomPaint(
            key: ValueKey<Offset>(_bottomWidgetOffset),
            painter: LinePainter(
              firstOffset: _topWidgetOffset,
              secondOffset: _bottomWidgetOffset,
            ),
          ),
        ],
      ),
    );
  }
}
