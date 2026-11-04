import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(10), color: Colors.white),
                      child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('Nomor Layanan Terdekat',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    ),
                  ),
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(10), color: Colors.white),
                    child: const Icon(Icons.explore_outlined, size: 18, color: AppColors.bluePrimary),
                  ),
                ],
              ),
            ),

            // GPS status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.gps_fixed, size: 14, color: AppColors.green),
                  const SizedBox(width: 6),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12),
                      children: [
                        TextSpan(text: 'GPS aktif', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.green)),
                        TextSpan(text: ' • Lokasi Anda saat ini', style: TextStyle(color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Map
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 220,
                  color: const Color(0xFFE8EEF5),
                  child: Stack(
                    children: [
                      SizedBox.expand(child: CustomPaint(painter: _ServiceMapPainter())),
                      // Map controls
                      Positioned(
                        bottom: 10, right: 10,
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

            const SizedBox(height: 14),

            // Service list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildServiceRow(icon: Icons.local_police, iconColor: AppColors.bluePrimary, iconBg: AppColors.blueSurface1, name: 'Polisi', dist: '1,2 km'),
                    _buildDivider(),
                    _buildServiceRow(icon: Icons.local_fire_department, iconColor: AppColors.redBright, iconBg: const Color(0xFFFFEBEA), name: 'Damkar', dist: '2,4 km'),
                    _buildDivider(),
                    _buildServiceRow(icon: Icons.local_hospital, iconColor: AppColors.green, iconBg: const Color(0xFFD1FAE5), name: 'Rumah Sakit', dist: '1,5 km'),
                    _buildDivider(),
                    _buildServiceRow(icon: Icons.bloodtype, iconColor: AppColors.redDark, iconBg: AppColors.redSurface1, name: 'PMI', dist: '2,8 km'),
                  ],
                ),
              ),
            ),

            SigapBottomNav(
              currentIndex: 0,
              onTap: (i) {
                if (i == 0) context.go('/home');
                else if (i == 2) context.push('/camera');
                else if (i == 3) context.push('/community');
                else if (i == 4) context.push('/history');
              },
              variant: SigapNavVariant.services,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControl(IconData icon) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)]),
      child: Icon(icon, size: 18, color: AppColors.textSecondarySlate),
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
            width: 44, height: 44,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text(dist, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: AppColors.blueSurface1, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.phone, color: AppColors.bluePrimary, size: 18),
          ),
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
    final bg = Paint()..color = const Color(0xFFE8EEF5);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Roads
    final road = Paint()..color = Colors.white..strokeWidth = 10;
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), road);
    canvas.drawLine(Offset(size.width * 0.35, 0), Offset(size.width * 0.35, size.height), road);

    // Blocks
    final block = Paint()..color = const Color(0xFFD0DCF0);
    canvas.drawRect(Rect.fromLTWH(10, 10, size.width * 0.3, size.height * 0.4), block);
    canvas.drawRect(Rect.fromLTWH(10, size.height * 0.55, size.width * 0.3, size.height * 0.4), block);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.4, 10, size.width * 0.55, size.height * 0.4), block);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.4, size.height * 0.55, size.width * 0.55, size.height * 0.4), block);

    // User circle
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 30, Paint()..color = AppColors.bluePrimary.withOpacity(0.15));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 10, Paint()..color = AppColors.bluePrimary);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 6, Paint()..color = Colors.white);

    // Markers
    _drawMarker(canvas, Offset(size.width * 0.2, size.height * 0.25), const Color(0xFFE53935));
    _drawMarker(canvas, Offset(size.width * 0.75, size.height * 0.3), const Color(0xFFE53935));
    _drawPlusMarker(canvas, Offset(size.width * 0.8, size.height * 0.6), const Color(0xFFE53935));
  }

  void _drawMarker(Canvas canvas, Offset center, Color color) {
    canvas.drawCircle(center, 12, Paint()..color = color);
    canvas.drawCircle(center, 7, Paint()..color = Colors.white);
    canvas.drawCircle(center, 4, Paint()..color = color);
  }

  void _drawPlusMarker(Canvas canvas, Offset center, Color color) {
    canvas.drawCircle(center, 12, Paint()..color = color);
    final white = Paint()..color = Colors.white..strokeWidth = 2.5;
    canvas.drawLine(center.translate(-5, 0), center.translate(5, 0), white);
    canvas.drawLine(center.translate(0, -5), center.translate(0, 5), white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
