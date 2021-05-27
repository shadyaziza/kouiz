import 'package:flutter/material.dart';
import 'package:kouiz/theme/theme.dart';
import 'package:simple_animations/simple_animations.dart';

class ParticlesBackground extends StatelessWidget {
  const ParticlesBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: kBackgroundColor
              // backgroundBlendMode: BlendMode.color,
              ),
          child: PlasmaRenderer(
            type: PlasmaType.infinity,
            particles: 7,
            color: kParticlesColor,
            blur: 0.11,
            size: 0.1,
            speed: 1.45,
            offset: 0,
            blendMode: BlendMode.srcOver,
            particleType: ParticleType.atlas,
            variation1: 0,
            variation2: 0,
            variation3: 0,
            rotation: 0,
          ),
        ),
        child,
      ],
    );
  }
}
