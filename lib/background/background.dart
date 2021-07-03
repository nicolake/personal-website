import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff003366),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color(0x442d69e6),
        blur: 0.4,
        size: 1,
        speed: 3.38,
        offset: 0,
        blendMode: BlendMode.screen,
        particleType: ParticleType.atlas,
        variation1: 0.05,
        variation2: 0.01,
        variation3: 0.06,
        rotation: 0,
      ),
    );
  }
}
