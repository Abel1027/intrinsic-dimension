import 'package:flutter/material.dart';

class IntrinsicDimension extends StatefulWidget {
  /// [IntrinsicDimension] exposes a [builder] to get the dimensions
  /// of the widget returned from the [builder].
  ///
  /// How it works:
  ///
  /// 1. In the first frame drawn by the screen it is computed the `width`,
  /// `height`, and the `startOffset` the widget is drawn from the top left corner
  /// of the screen which is the (0, 0). At this time, the [builder] only
  /// offers a `width` and `height` equal to zero and a `startOffset` equal
  /// to (0, 0).
  ///
  /// 2. Next, in the second frame, it is already known the dimensions of the
  /// widget and the [builder] offers such dimensions via `width`, `heigth`,
  /// and `startOffset` parameters.
  ///
  /// ```dart
  /// IntrinsicDimension(
  ///   builder: (context, width, height, startOffset) {
  ///     // do stuff here based on widget's width, height and startOffset
  ///     // and return a widget
  ///     return Row(
  ///       children: [
  ///         Container(
  ///           width: 2,
  ///           height: height,
  ///           color: Colors.black,
  ///         ),
  ///         const SizedBox(width: 8),
  ///         Column(
  ///           crossAxisAlignment: CrossAxisAlignment.start,
  ///           children: const [
  ///             Text('Title'),
  ///             Text('Description'),
  ///           ],
  ///         ),
  ///       ],
  ///     );
  ///   },
  /// ),
  /// ```

  const IntrinsicDimension({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// The [builder] callback function which is invoked on each widget build.
  /// The [builder] takes the `BuildContext`, the `width`, the `height`,
  /// and the `startOffset` from where the widget is drawn.
  /// The [builder] must return a widget. This is the widget from where
  /// is retrieved the width, height, and offset.
  final Widget Function(
    BuildContext context,
    double width,
    double height,
    Offset startOffset,
  ) builder;

  @override
  State<IntrinsicDimension> createState() => _IntrinsicDimensionState();
}

class _IntrinsicDimensionState extends State<IntrinsicDimension> {
  /// The private variable [_widgetKey] is used to assign a `GlobalKey`
  /// to the widget. With the [_widgetKey] is obtained the widget's
  /// render box which gives the widget's dimensions and offset.
  late GlobalKey _widgetKey;

  /// The private variable [_width] is used to assign the width of
  /// the widget.
  late double _width;

  /// The private variable [_height] is used to assign the height of
  /// the widget.
  late double _height;

  /// The private variable [_startOffset] is used to assign the offset
  /// from where the widget is drawn related to the top left corner of
  /// the screen (0, 0).
  late Offset _startOffset;

  @override
  void initState() {
    super.initState();
    _widgetKey = GlobalKey();
    _width = 0;
    _height = 0;
    _startOffset = Offset.zero;
    WidgetsBinding.instance?.addPostFrameCallback(_getDimensionsAfterLayout);
  }

  void _getDimensionsAfterLayout(_) {
    setState(() {
      if (_widgetKey.currentContext != null) {
        final _widgetRenderBox =
            _widgetKey.currentContext!.findRenderObject() as RenderBox;

        _width = _widgetRenderBox.paintBounds.right;
        _height = _widgetRenderBox.paintBounds.bottom;
        _startOffset = _widgetRenderBox.localToGlobal(Offset.zero);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _widgetKey,
      child: widget.builder.call(context, _width, _height, _startOffset),
    );
  }
}
