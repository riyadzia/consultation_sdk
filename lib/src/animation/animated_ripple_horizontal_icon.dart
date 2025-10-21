import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/animation/curve_line_riple.dart';

class AnimatedRippleHorizontalIcon extends StatefulWidget {
  const AnimatedRippleHorizontalIcon({super.key,
    this.color = const Color(0xff16020B),
    this.size = 28.0,
    this.startAngle = 2,
    this.sweepAngle = 2,
    required this.child
  });
  final Color color;
  final double size;
  final Widget child;
  final int startAngle;
  final int sweepAngle;

  @override
  AnimatedRippleIconState createState() => AnimatedRippleIconState();
}

class AnimatedRippleIconState extends State<AnimatedRippleHorizontalIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Animated lines
        Row(
          children: [
            widget.child,
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: RipplePainter(_controller.value,widget.color,startAngle: widget.startAngle,sweepAngle: widget.sweepAngle),
                  size: Size(widget.size, widget.size),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}