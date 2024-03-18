import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class PinchZoomImage extends StatefulWidget {
  final String imageUrl;

  const PinchZoomImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _PinchZoomImageState createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _previousScale = _scale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = _previousScale * details.scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      child: Center(
        child: Transform.scale(
          scale: _scale,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
          ),
        ),
      ),
    );
  }
}