import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable ring-shaped status/progress indicator with a gap at the
/// bottom and a customizable widget (icon, SVG, image, etc.) in the center.
///
/// Geometry:
/// - The full track spans the circle except for a small [gapDegrees] gap
///   centered at the bottom (6 o'clock).
/// - The colored "progress" arc is anchored at the TOP (12 o'clock) and
///   sweeps clockwise toward the right edge of the gap as [progress] goes
///   from 0 -> 1. This keeps the blue arc from ever overlapping the gap,
///   no matter what progress value is passed in.
class ProgressCircularElement extends StatefulWidget {
  final double size;
  final double progress; // 0.0 to 1.0
  final Duration duration;
  final Curve curve;
  final double gapDegrees;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;
  final bool showSvg;
  final String svgPath;

  /// Optional widget shown in the center of the ring (e.g. an
  /// `SvgPicture.asset(...)` from `flutter_svg`, an `Icon`, or an `Image`).
  /// Falls back to a car icon if not provided, so this widget stays
  /// drop-in compatible with earlier usages.
  final Widget? centerIcon;

  const ProgressCircularElement({
    super.key,
    this.size = 120,
    this.progress = 0.6,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeOutCubic,
    this.gapDegrees = 40,
    this.strokeWidth = 6,
    this.trackColor = Colors.white,
    this.progressColor = const Color(0xFF2D5BFF),
    this.centerIcon,
    this.showSvg = false,
    this.svgPath = '',
  });

  @override
  State<ProgressCircularElement> createState() =>
      _ProgressCircularElementState();
}

class _ProgressCircularElementState extends State<ProgressCircularElement>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _progressAnim = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    // Start the sweep as soon as the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void didUpdateWidget(covariant ProgressCircularElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If progress changes later (e.g. status updates), animate to the new
    // value starting from wherever the ring currently is.
    if (oldWidget.progress != widget.progress) {
      _progressAnim = Tween<double>(
        begin: _progressAnim.value,
        end: widget.progress,
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RingPainter(
                  progress: _progressAnim.value,
                  gapDegrees: widget.gapDegrees,
                  strokeWidth: widget.strokeWidth,
                  trackColor: widget.trackColor,
                  progressColor: widget.progressColor,
                ),
              );
            },
          ),
          // Reusable center content: pass an SVG, Icon, Image, or anything
          // else. Defaults to a car icon if nothing is supplied.
          SizedBox(
            width: widget.size * 0.4,
            height: widget.size * 0.4,
            child: widget.showSvg
                ? SvgPicture.asset(
                    widget.svgPath,
                    width: widget.size * 0.35,
                    height: widget.size * 0.35,
                    color: Colors.black87,
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final double gapDegrees;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;

  _RingPainter({
    required this.progress,
    required this.gapDegrees,
    required this.strokeWidth,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2) - 2;

    final gapRadians = gapDegrees * pi / 180;
    // Full track: everything except the bottom gap.
    final trackStart =
        (pi / 2) + (gapRadians / 2); // just past the gap, left side
    final trackSweep = (2 * pi) - gapRadians;

    // Progress arc: anchored at the TOP (12 o'clock) and sweeps clockwise.
    // Its max reach (progress = 1) lands exactly on the right edge of the
    // gap, so it can never sweep across the gap itself.
    const topAngle = -pi / 2;
    final maxProgressSweep = trackSweep / 2;

    final basePaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Background arc (full track, minus the gap).
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      trackStart,
      trackSweep,
      false,
      basePaint,
    );

    // Foreground arc (progress), growing from the top.
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      topAngle,
      maxProgressSweep * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.gapDegrees != gapDegrees ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.progressColor != progressColor;
}

// Example usage:
//
// class DemoPage extends StatelessWidget {
//   const DemoPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF00C896),
//       body: Center(
//         child: CarStatusRing(
//           progress: 0.65,
//           // Requires the flutter_svg package:
//           // centerIcon: SvgPicture.asset('assets/icons/car.svg'),
//         ),
//       ),
//     );
//   }
// }
