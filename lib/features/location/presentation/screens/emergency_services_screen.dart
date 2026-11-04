import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      child: Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF1E293B)),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Nomor Layanan Terdekat',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Icon(Icons.gps_fixed, size: 22, color: AppColors.bluePrimary),
                  ),
                ],
              ),
            ),

            // GPS status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.gps_fixed, size: 14, color: Color(0xFF10B981)),
                  const SizedBox(width: 6),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12),
                      children: [
                        TextSpan(
                          text: 'GPS aktif',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF10B981)),
                        ),
                        TextSpan(
                          text: ' • Lokasi Anda saat ini',
                          style: TextStyle(color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Map Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 340,
                  color: const Color(0xFFE8EEF5),
                  child: Stack(
                    children: [
                      SizedBox.expand(child: CustomPaint(painter: _ServiceMapPainter())),
                      // Map controls (Bulat di kanan bawah)
                      Positioned(
                        bottom: 14,
                        right: 14,
                        child: Column(
                          children: [
                            _buildMapControl(Icons.settings_outlined),
                            const SizedBox(height: 8),
                            _buildMapControl(Icons.my_location),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Service list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildServiceRow(
                    icon: Icons.shield,
                    iconColor: Colors.white,
                    iconBg: const Color(0xFF2563EB),
                    name: 'Polisi',
                    dist: '1,2 km',
                  ),
                  _buildDivider(),
                  _buildServiceRow(
                    icon: Icons.directions_car_filled,
                    iconColor: Colors.white,
                    iconBg: const Color(0xFFDC2626),
                    name: 'Damkar',
                    dist: '2,4 km',
                  ),
                  _buildDivider(),
                  _buildServiceRow(
                    icon: Icons.add_box,
                    iconColor: Colors.white,
                    iconBg: const Color(0xFF059669),
                    name: 'Rumah Sakit',
                    dist: '1,5 km',
                  ),
                  _buildDivider(),
                  _buildServiceRow(
                    icon: Icons.remove_circle,
                    iconColor: Colors.white,
                    iconBg: const Color(0xFFDC2626),
                    name: 'PMI',
                    dist: '2,8 km',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControl(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF475569)),
    );
  }

  Widget _buildServiceRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String name,
    required String dist,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dist,
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.phone, color: Color(0xFF2563EB), size: 22),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: const Color(0xFFF1F5F9));
  }
}

class _ServiceMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF1F5F9);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Diagonal and grid street lines
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, size.height * 0.2), Offset(size.width, size.height * 0.7), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.1), roadPaint);
    canvas.drawLine(Offset(size.width * 0.2, 0), Offset(size.width * 0.8, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.8, 0), Offset(size.width * 0.2, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width, size.height * 0.6), roadPaint);

    // Light block shapes
    final blockGreen = Paint()..color = const Color(0xFFDCFCE7).withValues(alpha: 0.7);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.08, size.height * 0.08, 64, 44), const Radius.circular(8)), blockGreen);

    final blockGrey = Paint()..color = const Color(0xFFE2E8F0).withValues(alpha: 0.6);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.65, size.height * 0.2, 70, 50), const Radius.circular(8)), blockGrey);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.15, size.height * 0.55, 80, 55), const Radius.circular(8)), blockGrey);

    // User radar/beacon
    canvas.drawCircle(Offset(size.width * 0.48, size.height * 0.45), 45, Paint()..color = const Color(0xFF3B82F6).withValues(alpha: 0.12));
    canvas.drawCircle(Offset(size.width * 0.48, size.height * 0.45), 26, Paint()..color = const Color(0xFF3B82F6).withValues(alpha: 0.25));
    canvas.drawCircle(Offset(size.width * 0.48, size.height * 0.45), 10, Paint()..color = const Color(0xFF2563EB));
    canvas.drawCircle(Offset(size.width * 0.48, size.height * 0.45), 5, Paint()..color = Colors.white);

    // Markers on map
    // Fire marker (red)
    _drawPinMarker(canvas, Offset(size.width * 0.42, size.height * 0.28), const Color(0xFFDC2626), Icons.local_fire_department);
    // Hospital marker (red plus)
    _drawPinMarker(canvas, Offset(size.width * 0.78, size.height * 0.35), const Color(0xFFEF4444), Icons.add);
  }

  void _drawPinMarker(Canvas canvas, Offset center, Color color, IconData icon) {
    canvas.drawCircle(center, 14, Paint()..color = color);
    // little pin stem dot
    canvas.drawCircle(Offset(center.dx, center.dy + 18), 3, Paint()..color = color);

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 14,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 7, center.dy - 7));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
