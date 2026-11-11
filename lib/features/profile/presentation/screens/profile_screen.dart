import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Back button (chevron left)
              GestureDetector(
                onTap: () => context.pop(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF1E293B)),
                ),
              ),

              const SizedBox(height: 16),

              // User Info Header (Avatar di kiri, nama & nomor di kanan)
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2E8F0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 38,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Syifa Khaerunisa Nabila',
                          style: TextStyle(
                            fontFamily: 'LiberationSans',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+62 8xxxxxxxxxx',
                          style: TextStyle(
                            fontFamily: 'LiberationSans',
                            fontSize: 13,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Menu Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.edit_outlined,
                      label: 'Edit Profil',
                      onTap: () {
                        context.push('/edit-profile');
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.group_outlined,
                      label: 'Kontak Darurat',
                      onTap: () {
                        context.push('/emergency-contacts');
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      label: 'Pengaturan',
                      onTap: () {
                        context.push('/settings');
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.error_outline,
                      label: 'Bantuan',
                      onTap: () {
                        context.push('/bantuan');
                      },
                    ),
                    _buildDivider(),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      label: 'Tentang SIGAP',
                      onTap: () {
                        context.push('/tentang-sigap');
                      },
                    ),
                    ],  
                    ),
                  
                ),
              

              const Spacer(),

              // Keluar Button
              SizedBox(
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
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Keluar',
                    style: TextStyle(
                      fontFamily: 'LiberationSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF475569)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'LiberationSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: const Color(0xFFF1F5F9),
      );

  
  // ignore: unused_element
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
