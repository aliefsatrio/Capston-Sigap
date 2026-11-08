import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    // Confetti / decoration elements
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Confetti decoration
                        _buildConfetti(),
                        // Check circle
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: AppColors.redSurface1,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(14),
                            decoration: const BoxDecoration(
                              color: AppColors.redPrimary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 36),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Laporan Berhasil Dikirim!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LiberationSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Terima kasih sudah melaporkan kejadian. Informasi akan ditampilkan di komunitas setelah diverifikasi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LiberationSans',
                          fontSize: 14,
                          color: AppColors.textSecondaryLight,
                          height: 1.57,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Lihat Laporan button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => context.go('/history'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Lihat Laporan Saya',
                            style: TextStyle(fontFamily: 'LiberationSans', fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Skyline decoration
                    _buildSkylineDecoration(),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SigapBottomNav(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) {
            context.go('/home');
          // ignore: curly_braces_in_flow_control_structures
          } else if (i == 1) context.push('/first-aid');
          // ignore: curly_braces_in_flow_control_structures
          else if (i == 3) context.push('/community');
          
        },
        variant: SigapNavVariant.home,
      ),
    );
  }

  Widget _buildConfetti() {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(painter: _ConfettiPainter()),
    );
  }

  Widget _buildSkylineDecoration() {
    return SizedBox(
      height: 100,
      child: CustomPaint(
        size: const Size(double.infinity, 100),
        painter: _SuccessSkylinePainter(),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [AppColors.redPrimary, AppColors.redSurface1, const Color(0xFFFFB3B3), const Color(0xFFFF8A80)];
    final center = Offset(size.width / 2, size.height / 2);
    const r = 70.0;

    for (int i = 0; i < 12; i++) {
      final ox = center.dx + (r + 20) * (i % 2 == 0 ? 1 : -1) * (0.5 + (i % 3) * 0.3);
      final oy = center.dy + (r + 20) * (0.5 + (i % 4) * 0.2) * (i < 6 ? -1 : 1);
      canvas.drawCircle(
        Offset(ox, oy),
        3 + (i % 3).toDouble(),
        Paint()..color = colors[i % colors.length].withValues(alpha: 0.7),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SuccessSkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.redSurface1.withValues(alpha: 0.6);

    final buildings = [
      Rect.fromLTWH(0, size.height * 0.4, 30, size.height * 0.6),
      Rect.fromLTWH(25, size.height * 0.2, 40, size.height * 0.8),
      Rect.fromLTWH(60, size.height * 0.5, 30, size.height * 0.5),
      Rect.fromLTWH(85, size.height * 0.3, 50, size.height * 0.7),
      Rect.fromLTWH(130, size.height * 0.4, 35, size.height * 0.6),
      Rect.fromLTWH(160, size.height * 0.15, 55, size.height * 0.85),
      Rect.fromLTWH(210, size.height * 0.35, 40, size.height * 0.65),
      Rect.fromLTWH(245, size.height * 0.25, 60, size.height * 0.75),
      Rect.fromLTWH(300, size.height * 0.4, 35, size.height * 0.6),
      Rect.fromLTWH(330, size.height * 0.3, 50, size.height * 0.7),
    ];

    for (final b in buildings) {
      canvas.drawRect(b, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
