import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar (Background putih/terang)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.arrow_back, size: 24, color: Color(0xFF1E293B)),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Lapor Kejadian',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'SOS',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(Icons.person, size: 20, color: Color(0xFF475569)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Camera Viewfinder Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: const Color(0xFF1E293B),
                  child: Stack(
                    children: [
                      // Simulated street camera scene
                      SizedBox.expand(
                        child: CustomPaint(painter: _CameraScenePainter()),
                      ),

                      // Gradient overlay for readability
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.55),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                              stops: const [0.0, 0.25, 0.65, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Top Controls Row: LIVE SENSOR, REC 00:14, Flash, Flip
                      Positioned(
                        top: 12,
                        left: 12,
                        right: 12,
                        child: Row(
                          children: [
                            // LIVE SENSOR badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.fiber_manual_record, color: Color(0xFFEF4444), size: 10),
                                  SizedBox(width: 4),
                                  Text(
                                    'LIVE SENSOR',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            // REC 00:14
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.fiber_manual_record, color: Color(0xFFEF4444), size: 10),
                                  SizedBox(width: 4),
                                  Text(
                                    'REC 00:14',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            // Flash Off button
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.flash_off, color: Colors.white, size: 17),
                            ),
                            const SizedBox(width: 6),
                            // Flip camera button
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.4),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.cameraswitch_outlined, color: Colors.white, size: 17),
                            ),
                          ],
                        ),
                      ),

                      // Authenticity red banner
                      Positioned(
                        top: 52,
                        left: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDC2626),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_user_outlined, color: Colors.white, size: 15),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Foto langsung wajib demi keaslian laporan',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Center Scan Area Reticle & Labels
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomPaint(
                              size: const Size(200, 140),
                              painter: _ReticleCornersPainter(),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Scan Area',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFBBF24),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    'Deteksi Kendaraan...',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    'Kejadian: Kecelakaan Ringan (Motorcycle)',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Bottom Floating Location & Time Card
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B).withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.white70, size: 14),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Jl. Pancasila, Tegal (-6.8797, 109.1256)',
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.white70, size: 13),
                                  SizedBox(width: 6),
                                  Text(
                                    '10 Nov 2026, 09:41 WIB',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.satellite_alt, color: Colors.white70, size: 13),
                                  SizedBox(width: 4),
                                  Text(
                                    '± 2m (Tinggi)',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Bottom White Area: Big Record Button + Info Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Large Circular Record Button
                      GestureDetector(
                        onTap: () => context.push('/description'),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFEE2E2),
                            border: Border.all(color: const Color(0xFFFECACA), width: 2),
                          ),
                          child: Center(
                            child: Container(
                              width: 62,
                              height: 62,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFDC2626),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Info Panel
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, size: 16, color: Color(0xFF2563EB)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Foto akan otomatis menyertakan lokasi GPS presisi dan waktu kejadian untuk verifikasi instan tim SIGAP.',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 11.5,
                                  color: Color(0xFF334155),
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ReticleCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 24.0;

    // Top-left
    canvas.drawLine(const Offset(0, 0), const Offset(cornerLength, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, cornerLength), paint);

    // Top-right
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - cornerLength, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint);

    // Bottom-left
    canvas.drawLine(Offset(0, size.height), Offset(cornerLength, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - cornerLength), paint);

    // Bottom-right
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - cornerLength, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - cornerLength), paint);

    // Dotted inner frame
    final dashedPaint = Paint()
      ..color = const Color(0xFFFBBF24).withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(10, 10, size.width - 20, size.height - 20);
    canvas.drawRect(rect, dashedPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CameraScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Street asphalt
    final road = Paint()..color = const Color(0xFF334155);
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.45, size.width, size.height * 0.55), road);

    // Sky & distant buildings
    final sky = Paint()..color = const Color(0xFF64748B);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.45), sky);

    final bldg1 = Paint()..color = const Color(0xFF475569);
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.15, size.width * 0.35, size.height * 0.3), bldg1);

    final bldg2 = Paint()..color = const Color(0xFF3B485A);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.65, size.height * 0.12, size.width * 0.35, size.height * 0.33), bldg2);

    // Road markings
    final dash = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 4;
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.5), Offset(size.width * 0.5, size.height * 0.6), dash);
    canvas.drawLine(Offset(size.width * 0.5, size.height * 0.7), Offset(size.width * 0.5, size.height * 0.82), dash);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
