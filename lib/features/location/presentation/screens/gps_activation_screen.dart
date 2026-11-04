import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class GpsActivationScreen extends StatefulWidget {
  const GpsActivationScreen({super.key});

  @override
  State<GpsActivationScreen> createState() => _GpsActivationScreenState();
}

class _GpsActivationScreenState extends State<GpsActivationScreen> {
  String _selectedPermission = 'while_using'; // 'while_using' | 'once'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'SIGAP Keamanan',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.redPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.shield, color: AppColors.redPrimary, size: 16),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // GPS Visual
                    _buildGpsVisual(),
                    const SizedBox(height: 8),

                    // Badges
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildBadge(Icons.my_location, 'Radius: ± 3-5 meter', AppColors.bluePrimary, AppColors.blueSurface1),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.redSurface1,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.redPrimary),
                          SizedBox(width: 4),
                          Text(
                            'Wajib untuk Respon Cepat Darurat',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.redPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aktifkan Lokasi GPS Anda',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
                                color: AppColors.textSecondaryLight,
                                height: 1.6,
                              ),
                              children: [
                                TextSpan(text: 'SIGAP memerlukan akses GPS presisi tinggi real-time untuk mendeteksi posisi akurat Anda saat menekan '),
                                TextSpan(
                                  text: 'Tombol Darurat',
                                  style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.redPrimary),
                                ),
                                TextSpan(text: ' dan menyematkan koordinat otomatis pada setiap laporan foto kejadian.'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Benefit cards
                          _buildBenefitCard(
                            icon: Icons.gps_fixed,
                            iconColor: AppColors.redPrimary,
                            title: 'Presisi Tim Penyelamat',
                            description: 'Polisi, Damkar, dan Ambulans terdekat langsung mengarah ke titik koordinat tepat tanpa menunggu konfirmasi alamat verbal.',
                          ),
                          const SizedBox(height: 12),
                          _buildBenefitCard(
                            icon: Icons.notifications_active_outlined,
                            iconColor: AppColors.amber,
                            title: 'Notifikasi Bencana Sekitar',
                            description: 'Peringatan dini otomatis insiden bencana, kebakaran, atau kecelakaan dalam radius 2-5 km dari zona Anda saat ini.',
                          ),
                          const SizedBox(height: 12),
                          _buildBenefitCard(
                            icon: Icons.verified_outlined,
                            iconColor: AppColors.green,
                            title: 'Validasi Foto Otomatis',
                            description: 'Mencegah laporan palsu dengan penyematan metadata geotagging terenkripsi langsung dari sensor kamera perangkat.',
                          ),

                          const SizedBox(height: 20),

                          // Permission dialog illustration (not real system dialog)
                          _buildPermissionPanel(),

                          const SizedBox(height: 20),

                          // CTA: Aktifkan GPS
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: () => context.go('/home'),
                              icon: const Icon(Icons.gps_fixed, size: 18),
                              label: const Text(
                                'Aktifkan GPS Sekarang',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.redPrimary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                elevation: 0,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Atur Nanti
                          Center(
                            child: GestureDetector(
                              onTap: () => context.go('/home'),
                              child: const Text(
                                'Atur Nanti di Pengaturan',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 14,
                                  color: AppColors.textSecondarySlate,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Note
                          const Text(
                            'Catatan: Tombol Darurat instan & pelacakan ambulans otomatis akan terbatas tanpa GPS aktif.',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 11,
                              color: AppColors.textMuted,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGpsVisual() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Concentric circles
          ...List.generate(4, (i) {
            final size = 60.0 + i * 36;
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.redPrimary.withValues(alpha: 0.07 - i * 0.015),
              ),
            );
          }),
          // Center icon
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: AppColors.redPrimary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.my_location, color: Colors.white, size: 28),
          ),
          // AKURASI TINGGI badge
          Positioned(
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.redPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                'AKURASI TINGGI',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color iconColor, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: iconColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondaryLight, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FC),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, color: AppColors.redPrimary, size: 18),
                SizedBox(width: 8),
                Text(
                  'Dialog Izin Sistem (Android/iOS)',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Izinkan SIGAP mengakses perkiraan dan presisi lokasi perangkat ini?',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textPrimary, height: 1.5),
                ),
                const SizedBox(height: 12),
                // Option 1
                GestureDetector(
                  onTap: () => setState(() => _selectedPermission = 'while_using'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedPermission == 'while_using' ? AppColors.blueSurface1 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _selectedPermission == 'while_using' ? AppColors.bluePrimary : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Saat Aplikasi Digunakan (Disarankan)',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              color: _selectedPermission == 'while_using' ? AppColors.bluePrimary : AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (_selectedPermission == 'while_using')
                          const Icon(Icons.check_circle, color: AppColors.bluePrimary, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Option 2
                GestureDetector(
                  onTap: () => setState(() => _selectedPermission = 'once'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedPermission == 'once' ? AppColors.blueSurface1 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _selectedPermission == 'once' ? AppColors.bluePrimary : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hanya Kali Ini',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              color: _selectedPermission == 'once' ? AppColors.bluePrimary : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          width: 20, height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedPermission == 'once' ? AppColors.bluePrimary : const Color(0xFFCBD5E1),
                              width: 2,
                            ),
                          ),
                          child: _selectedPermission == 'once'
                              ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.bluePrimary, shape: BoxShape.circle)))
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
