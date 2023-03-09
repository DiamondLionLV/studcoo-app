import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientSvgIcon extends StatelessWidget {
  final String svgAssetPath;
  final Gradient gradient;
  final double width;
  final double height;

  GradientSvgIcon({
    required this.svgAssetPath,
    required this.gradient,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: SvgPicture.asset(
        svgAssetPath,
        width: width,
        height: height,
      ),
    );
  }
}
