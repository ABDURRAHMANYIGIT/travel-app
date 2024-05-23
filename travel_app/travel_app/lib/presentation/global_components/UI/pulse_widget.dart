// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PulseWidget extends StatefulWidget {
  const PulseWidget({
    super.key,
    required this.child,
    required this.endRadius,
    this.shape = BoxShape.circle,
    this.duration = const Duration(milliseconds: 2000),
    this.repeat = true,
    this.animate = true,
    this.repeatPauseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.fastOutSlowIn,
    this.showTwoGlows = true,
    this.glowColor = Colors.white,
    this.startDelay,
  });
  final Widget child;
  final double endRadius;
  final BoxShape shape;
  final Duration duration;
  final bool repeat;
  final bool animate;
  final Duration repeatPauseDuration;
  final Curve curve;
  final bool showTwoGlows;
  final Color glowColor;
  final Duration? startDelay;

  @override
  _PulseWidgetState createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<PulseWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );
  late final Animation<double> _smallDiscAnimation = Tween<double>(
    begin: (widget.endRadius * 2) / 6,
    end: (widget.endRadius * 2) * (3 / 4),
  ).animate(_curve);
  late final Animation<double> _bigDiscAnimation = Tween<double>(
    begin: 0.0,
    end: widget.endRadius * 2,
  ).animate(_curve);
  late final Animation<double> _alphaAnimation = Tween<double>(
    begin: 0.30,
    end: 0.0,
  ).animate(_controller);

  Future<void> _statusListener(AnimationStatus status) async {
    if (_controller.status == AnimationStatus.completed) {
      await Future<void>.delayed(widget.repeatPauseDuration);
      if (mounted && widget.repeat && widget.animate) {
        _controller.reset();
        _controller.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(PulseWidget oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _startAnimation() async {
    _controller.addStatusListener(_statusListener);
    if (widget.startDelay != null) {
      await Future<void>.delayed(widget.startDelay!);
    }
    if (mounted) {
      _controller.reset();
      _controller.forward();
    }
  }

  Future<void> _stopAnimation() async {
    _controller.removeStatusListener(_statusListener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _alphaAnimation,
      child: widget.child,
      builder: (_, Widget? widgetChild) {
        final BoxDecoration decoration = BoxDecoration(
          shape: widget.shape,
          // If the user picks a curve that goes below 0 or above 1
          // this opacity will have unexpected effects without clamping
          color: widget.glowColor.withOpacity(
            _alphaAnimation.value.clamp(0.0, 1.0),
          ),
        );
        return SizedBox(
          height: widget.endRadius * 2,
          width: widget.endRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (widget.animate)
                AnimatedBuilder(
                  animation: _bigDiscAnimation,
                  builder: (_, __) {
                    // If the user picks a curve that goes below 0,
                    // this will throw without clamping
                    final double size =
                        _bigDiscAnimation.value.clamp(0.0, double.infinity);

                    return Container(
                      height: size,
                      width: size,
                      decoration: decoration,
                    );
                  },
                )
              else
                const SizedBox(height: 0.0, width: 0.0),
              if (widget.animate && widget.showTwoGlows)
                AnimatedBuilder(
                  animation: _smallDiscAnimation,
                  builder: (_, __) {
                    final double size =
                        _smallDiscAnimation.value.clamp(0.0, double.infinity);

                    return Container(
                      height: size,
                      width: size,
                      decoration: decoration,
                    );
                  },
                )
              else
                const SizedBox(height: 0.0, width: 0.0),
              widgetChild!,
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
