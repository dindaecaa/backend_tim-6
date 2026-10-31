import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'scan_result_screen.dart';

class ScannerCameraScreen extends StatefulWidget {
  const ScannerCameraScreen({super.key});

  @override
  State<ScannerCameraScreen> createState() =>
      _ScannerCameraScreenState();
}

class _ScannerCameraScreenState
    extends State<ScannerCameraScreen> {
  late final MobileScannerController _controller;

  bool _isProcessing = false;
  bool _torchOn = false;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      facing: CameraFacing.back,
      detectionSpeed: DetectionSpeed.noDuplicates,
      torchEnabled: false,
      autoZoom: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // =============================================================
  // BARCODE DETECTED
  // =============================================================

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) {
      return;
    }

    if (capture.barcodes.isEmpty) {
      return;
    }

    final barcode = capture.barcodes.first.rawValue;

    if (barcode == null || barcode.trim().isEmpty) {
      return;
    }

    _isProcessing = true;

    await _controller.stop();

    if (!mounted) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResultScreen(
          barcode: barcode,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    _isProcessing = false;

    await _controller.start();
  }

  // =============================================================
  // FLASHLIGHT
  // =============================================================

  Future<void> _toggleFlashlight() async {
    await _controller.toggleTorch();

    if (!mounted) {
      return;
    }

    setState(() {
      _torchOn = !_torchOn;
    });
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // =====================================================
            // CAMERA
            // =====================================================

            Positioned.fill(
              child: MobileScanner(
                controller: _controller,
                fit: BoxFit.cover,
                onDetect: _onDetect,
              ),
            ),

            // =====================================================
            // DARK OVERLAY
            // =====================================================

            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _ScannerOverlayPainter(),
                ),
              ),
            ),

            // =====================================================
            // HEADER
            // =====================================================

            Positioned(
              top: 15,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  const SizedBox(width: 20),

                  const Expanded(
                    child: Text(
                      'Scan QR/Barcode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 31,
                        height: 31,
                        decoration:
                            const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF69717B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // SCANNER FRAME
            // =====================================================

            Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: CustomPaint(
                  painter: _ScannerFramePainter(),
                ),
              ),
            ),

            // =====================================================
            // FLASHLIGHT BUTTON
            // =====================================================

            Positioned(
              bottom: 135,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _toggleFlashlight,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.25,
                          ),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      _torchOn
                          ? Icons.flashlight_on
                          : Icons.flashlight_off_outlined,
                      size: 23,
                      color: const Color(0xFF587B55),
                    ),
                  ),
                ),
              ),
            ),

            // =====================================================
            // INSTRUCTION
            // =====================================================

            const Positioned(
              bottom: 76,
              left: 30,
              right: 30,
              child: Text(
                'Arahkan kamera ke barcode atau QR\ncode',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // =====================================================
            // SCANNING STATUS
            // =====================================================

            Positioned(
              bottom: 27,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(
                      alpha: 0.45,
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 7,
                        height: 7,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFF8ED19A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Mencari barcode...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================================================
// SCANNER FRAME
// ===============================================================

class _ScannerFramePainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    const color = Colors.white;

    const strokeWidth = 4.0;
    const cornerLength = 34.0;
    const radius = 18.0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final left = 1.5;
    final top = 1.5;
    final right = size.width - 1.5;
    final bottom = size.height - 1.5;

    // TOP LEFT

    canvas.drawPath(
      Path()
        ..moveTo(left + cornerLength, top)
        ..lineTo(left + radius, top)
        ..quadraticBezierTo(
          left,
          top,
          left,
          top + radius,
        )
        ..lineTo(left, top + cornerLength),
      paint,
    );

    // TOP RIGHT

    canvas.drawPath(
      Path()
        ..moveTo(right - cornerLength, top)
        ..lineTo(right - radius, top)
        ..quadraticBezierTo(
          right,
          top,
          right,
          top + radius,
        )
        ..lineTo(right, top + cornerLength),
      paint,
    );

    // BOTTOM LEFT

    canvas.drawPath(
      Path()
        ..moveTo(left, bottom - cornerLength)
        ..lineTo(left, bottom - radius)
        ..quadraticBezierTo(
          left,
          bottom,
          left + radius,
          bottom,
        )
        ..lineTo(left + cornerLength, bottom),
      paint,
    );

    // BOTTOM RIGHT

    canvas.drawPath(
      Path()
        ..moveTo(right, bottom - cornerLength)
        ..lineTo(right, bottom - radius)
        ..quadraticBezierTo(
          right,
          bottom,
          right - radius,
          bottom,
        )
        ..lineTo(right - cornerLength, bottom),
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}

// ===============================================================
// CAMERA OVERLAY
// ===============================================================

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final overlayPaint = Paint()
      ..color = Colors.black.withValues(
        alpha: 0.42,
      );

    const scanSize = 250.0;

    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2;

    final fullRect = Offset.zero & size;

    final scanRect = Rect.fromLTWH(
      left,
      top,
      scanSize,
      scanSize,
    );

    final path = Path()
      ..addRect(fullRect)
      ..addRRect(
        RRect.fromRectAndRadius(
          scanRect,
          const Radius.circular(18),
        ),
      );

    path.fillType = PathFillType.evenOdd;

    canvas.drawPath(
      path,
      overlayPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}