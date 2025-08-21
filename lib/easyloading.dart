import 'dart:ui';
import 'package:flutter/material.dart';

class EasyLoading {
  static OverlayEntry? _overlayEntry;

  /// Normal Loading
  static void show(
      BuildContext context, {
        Widget? progressIndicatorWidget,
        bool isBlur = true,
      }) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          if (!isBlur)
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.2),
            ),
          if (isBlur)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.green.withOpacity(0.4),
                        Colors.white.withOpacity(0.4),
                      ],
                    ),
                  ),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: progressIndicatorWidget ??
                        CircularProgressIndicator(
                          strokeWidth: 4,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Percentage Loading
  static void showProgress(BuildContext context, double percent) {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (_) => _buildBackground(
        child: _glassContainer(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  value: percent / 100,
                  strokeWidth: 4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "${percent.toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Dismiss Loading
  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // 🔹 Helpers
  static Widget _buildBackground({required Widget child}) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
        ),
        Center(child: child),
      ],
    );
  }

  static Widget _glassContainer({
    required Widget child,
    double? width,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width ?? 180,
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.6),
          ),
          child: child,
        ),
      ),
    );
  }
}
