import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String _selectedCategory = 'Kecelakaan';
  final List<String> _categories = ['Kecelakaan', 'Kebakaran', 'Bencana Alam', 'Tindak Kriminal', 'Lainnya'];

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      child: Text('Lapor Kejadian',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.redPrimary, borderRadius: BorderRadius.circular(8)),
                    child: const Text('SOS', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFFFDDBB),
                    child: Text('S', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: Color(0xFF7C4A00), fontSize: 12)),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Camera preview
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 260,
                          color: const Color(0xFF1A1A2E),
                          child: Stack(
                            children: [
                              // Simulated camera content
                              SizedBox.expand(
                                child: CustomPaint(painter: _CameraViewPainter()),
                              ),
                              // LIVE SENSOR badge
                              Positioned(
                                top: 12, left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: AppColors.redPrimary, borderRadius: BorderRadius.circular(6)),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.fiber_manual_record, color: Colors.white, size: 10),
                                      SizedBox(width: 4),
                                      Text('LIVE SENSOR', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              // Authenticity badge
                              Positioned(
                                top: 12, right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('Foto langsung wajib demi keaslian laporan',
                                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9, color: Colors.white)),
                                ),
                              ),
                              // Reticle
                              const Center(
                                child: Icon(Icons.crop_free, color: Colors.white54, size: 80),
                              ),
                              // Metadata overlay at bottom
                              Positioned(
                                bottom: 0, left: 0, right: 0,
                                child: Container(
                                  color: Colors.black.withOpacity(0.65),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, color: Colors.white70, size: 12),
                                          SizedBox(width: 4),
                                          Text('Jl. Pancasila, Tegal (-6.8797, 109.1256)',
                                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: Colors.white70)),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time, color: Colors.white70, size: 12),
                                          SizedBox(width: 4),
                                          Text('10 Nov 2026, 09:41 WIB',
                                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: Colors.white70)),
                                          SizedBox(width: 10),
                                          Icon(Icons.gps_fixed, color: Colors.white70, size: 12),
                                          SizedBox(width: 4),
                                          Text('± 2m (Tinggi)',
                                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: Colors.white70)),
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

                    const SizedBox(height: 14),

                    // Category section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text('Pilih Kategori Kejadian', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          Spacer(),
                          Text('Wajib diisi', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.redPrimary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Category chips - horizontal scroll
                    SizedBox(
                      height: 36,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          final cat = _categories[i];
                          final isSelected = cat == _selectedCategory;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedCategory = cat),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.redPrimary : Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: isSelected ? AppColors.redPrimary : const Color(0xFFE2E8F0)),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppColors.textSecondarySlate,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Camera controls
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildControl(Icons.mic_outlined, 'Voice Memo'),
                          _buildShutterButton(context),
                          _buildControl(Icons.help_outline, 'Bantuan'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Info panel
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.blueSurface1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, size: 16, color: AppColors.bluePrimary),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Foto akan otomatis menyertakan lokasi GPS presisi dan waktu kejadian untuk verifikasi instan tim SIGAP.',
                                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondarySlate, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

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
          if (i == 0) context.go('/home');
          else if (i == 3) context.push('/community');
          else if (i == 4) context.push('/history');
        },
        variant: SigapNavVariant.home,
      ),
    );
  }

  Widget _buildControl(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Icon(icon, color: AppColors.textSecondarySlate, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textSecondarySlate)),
      ],
    );
  }

  Widget _buildShutterButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/description'),
      child: Column(
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.redPrimary,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [BoxShadow(color: AppColors.redPrimary.withOpacity(0.4), blurRadius: 16)],
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }
}

class _CameraViewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dark background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = const Color(0xFF1A1A2E));

    // Simulated scene
    final road = Paint()..color = const Color(0xFF3A3A4E);
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.6, size.width, size.height * 0.4), road);

    final sky = Paint()..color = const Color(0xFF2A3A6E);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.4), sky);

    final bldg = Paint()..color = const Color(0xFF4A5A8E);
    canvas.drawRect(Rect.fromLTWH(10, size.height * 0.3, 60, size.height * 0.3), bldg);
    canvas.drawRect(Rect.fromLTWH(size.width - 80, size.height * 0.25, 70, size.height * 0.35), bldg);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
