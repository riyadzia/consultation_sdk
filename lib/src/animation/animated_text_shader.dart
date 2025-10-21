import 'package:flutter/material.dart';
import 'package:consultation_sdk/src/core/app_colors.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/global_widget/custom_text.dart';

class AnimatedTextShader extends StatefulWidget {
  const AnimatedTextShader({super.key});
  // final String text;

  @override
  State<AnimatedTextShader> createState() => _AnimatedTextShaderState();
}

class _AnimatedTextShaderState extends State<AnimatedTextShader>     with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // late Animation<double> _textSizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true); // Loops animation

    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    // _textSizeAnimation = Tween<double>(begin: 12, end: 12.5).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(getWidth(14)),
        bottomLeft: Radius.circular(getWidth(50)),
      ),
      child: Container(
        // height: getWidth(28),
        padding: EdgeInsets.symmetric(horizontal: getWidth(16),vertical: getWidth(4)),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getWidth(14)),
            bottomLeft: Radius.circular(getWidth(50)),
          ),
        ),
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
            return ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  // colors: const [Colors.blue, Colors.purple, Colors.red],
                  colors: [
                    AppColors.mainColor,
                    Colors.blue,
                    Colors.purple,
                  ],
                  begin: Alignment(-1.0 + 2 * _animation.value, 0.0),
                  end: Alignment(1.0 + 2 * _animation.value, 0.0),
                ).createShader(bounds);
              },
              child: CustomText(
                  text: "Most Popular",
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainColor,
                  // fontSize: getWidth(_textSizeAnimation.value),
                  fontSize: getWidth(12)
              ),
            );
          }
        ),
      ),
    );
  }
}
