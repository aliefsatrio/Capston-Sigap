import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Avatar
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFFFDDBB),
                      child: Text(
                        'S',
                        style: TextStyle(fontFamily: 'LiberationSans', fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF7C4A00)),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Syifa Khaerunisa Nabila',
                      style: TextStyle(fontFamily: 'LiberationSans', fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '+62 8xxxxxxxxxx',
                      style: TextStyle(fontFamily: 'LiberationSans', fontSize: 12, color: AppColors.textMuted),
                    ),

                    const SizedBox(height: 28),

                    // Menu items
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(icon: Icons.edit_outlined, label: 'Edit Profil', onTap: () {}),
                            _buildDivider(),
                            _buildMenuItem(icon: Icons.emergency_outlined, label: 'Kontak Darurat', onTap: () {}),
                            _buildDivider(),
                            _buildMenuItem(icon: Icons.settings_outlined, label: 'Pengaturan', onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => _buildPlaceholderSheet('Pengaturan', 'Halaman Pengaturan belum memiliki desain referensi.'),
                              );
                            }),
                            _buildDivider(),
                            _buildMenuItem(icon: Icons.help_outline, label: 'Bantuan', onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => _buildPlaceholderSheet('Bantuan', 'Halaman Bantuan belum memiliki desain referensi.'),
                              );
                            }),
                            _buildDivider(),
                            _buildMenuItem(
                              icon: Icons.dashboard_customize_outlined,
                              label: 'Galeri Semua Layar (16 Layar)',
                              onTap: () => context.push('/gallery'),
                            ),
                            _buildDivider(),
                            _buildMenuItem(icon: Icons.info_outline, label: 'Tentang SIGAP', onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => _buildPlaceholderSheet('Tentang SIGAP', 'SIGAP v1.0.0\nSistem Informasi Pelaporan Kejadian Darurat'),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Keluar button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Keluar', style: TextStyle(fontFamily: 'LiberationSans', fontWeight: FontWeight.w700)),
                                content: const Text('Apakah Anda yakin ingin keluar?', style: TextStyle(fontFamily: 'LiberationSans')),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Text('Batal', style: TextStyle(fontFamily: 'LiberationSans')),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      context.go('/login');
                                    },
                                    child: const Text('Keluar', style: TextStyle(fontFamily: 'LiberationSans', color: AppColors.redPrimary, fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redPrimary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: const Text('Keluar',
                              style: TextStyle(fontFamily: 'LiberationSans', fontSize: 15, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),

            SigapBottomNav(
              currentIndex: -1, // Profile is not in home nav
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

  Widget _buildMenuItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppColors.bgGrey, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 18, color: AppColors.textSecondarySlate),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, color: AppColors.textPrimary)),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => Container(height: 1, margin: const EdgeInsets.symmetric(horizontal: 16), color: const Color(0xFFF1F5F9));

  Widget _buildPlaceholderSheet(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Text(desc, style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, color: AppColors.textSecondarySlate)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
