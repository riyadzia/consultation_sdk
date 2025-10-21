import 'package:flutter/material.dart';

class RippleIconScreen extends StatefulWidget {
  const RippleIconScreen({super.key});

  @override
  RippleIconScreenState createState() => RippleIconScreenState();
}

class RippleIconScreenState extends State<RippleIconScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat the animation

    // Define the animation curve
    _animation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ripple Effect Animation'),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ripple effect
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: 100 * _animation.value,
                  height: 100 * _animation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withValues(alpha: 1 - _animation.value),
                  ),
                );
              },
            ),

            // Icon in the center
            const Icon(
              Icons.network_wifi,
              size: 40,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}