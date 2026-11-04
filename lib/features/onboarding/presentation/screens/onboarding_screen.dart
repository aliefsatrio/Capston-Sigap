import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // Logo + Title
            Column(
              children: [
                // Logo SIGAP
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo_sigap.jpeg',
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'SIGAP',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.bluePrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Sistem Informasi Pelaporan Kejadian\nDarurat untuk Mendukung Pelayanan Publik',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondarySlate,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Illustration
            Expanded(
              child: _buildIllustration(),
            ),

            const SizedBox(height: 24),

            // Slogan
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Laporkan. Dapatkan informasi.\nBersama kita lebih aman.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.37,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Mulai button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.push('/register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bluePrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Mulai',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Home indicator
            Container(
              width: 128,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Sky background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFE0EAFF), Color(0xFFF0F4FF)],
                    ),
                  ),
                ),
              ),
            ),

            // City silhouette layer
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: const Size(double.infinity, 120),
                painter: _CitySilhouettePainter(),
              ),
            ),

            // Green trees
            Positioned(
              bottom: 20,
              left: 20,
              child: _buildTree(),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: _buildTree(),
            ),

            // Phone with pin
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pin above phone
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.redPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.location_on, color: Colors.white, size: 20),
                  ),
                  const SizedBox(height: 2),
                  // Phone
                  Container(
                    width: 70,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFBBC4FF), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0051D5).withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCBD5E1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Icon(Icons.map_outlined, color: AppColors.bluePrimary, size: 28),
                      ],
                    ),
                  ),
                  // Hand
                  Container(
                    width: 70,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFDDBB),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTree() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFF6AAF6E),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 10,
          height: 16,
          color: const Color(0xFF8B6914),
        ),
      ],
    );
  }
}

class _CitySilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFBBC4FF);

    // Draw building silhouettes
    final buildings = [
      Rect.fromLTWH(0, size.height * 0.3, 50, size.height * 0.7),
      Rect.fromLTWH(45, size.height * 0.1, 60, size.height * 0.9),
      Rect.fromLTWH(100, size.height * 0.4, 45, size.height * 0.6),
      Rect.fromLTWH(140, size.height * 0.2, 70, size.height * 0.8),
      Rect.fromLTWH(200, size.height * 0.35, 55, size.height * 0.65),
      Rect.fromLTWH(250, size.height * 0.15, 65, size.height * 0.85),
      Rect.fromLTWH(310, size.height * 0.3, 50, size.height * 0.7),
      Rect.fromLTWH(355, size.height * 0.5, 60, size.height * 0.5),
    ];

    for (final b in buildings) {
      canvas.drawRect(b, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
