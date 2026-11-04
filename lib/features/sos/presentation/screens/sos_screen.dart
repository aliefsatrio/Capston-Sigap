import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redBright,
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Siren icon
                  const Text('🚨', style: TextStyle(fontSize: 42)),
                  const SizedBox(height: 16),
                  const Text(
                    'Tombol Darurat',
                    style: TextStyle(
                      fontFamily: 'LiberationSans',
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      'Kirim pesan berisi lokasi ke kontak darurat kamu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'LiberationSans',
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // SOS Button with rings
                  _buildSosButton(context),

                  const SizedBox(height: 10),

                  const Text(
                    'Kirim Sekarang',
                    style: TextStyle(
                      fontFamily: 'LiberationSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Emergency contact card
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Kontak Darurat',
                          style: TextStyle(fontFamily: 'LiberationSans', fontSize: 11, color: AppColors.textMuted),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ibu',
                          style: TextStyle(fontFamily: 'LiberationSans', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        Text(
                          '+62 812-3456-7890',
                          style: TextStyle(fontFamily: 'LiberationSans', fontSize: 13, color: AppColors.textSecondarySlate),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.bgGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.edit_outlined, color: AppColors.textSecondarySlate, size: 18),
                    ),
                  ],
                ),
              ),
            ),

            // Home indicator
            Container(
              width: 128, height: 4,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSosButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('MODE DEMO', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700)),
            content: const Text(
              'Ini adalah simulasi. Tidak ada pesan darurat yang dikirim.',
              style: TextStyle(fontFamily: 'PlusJakartaSans'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK', style: TextStyle(fontFamily: 'PlusJakartaSans')),
              ),
            ],
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring 3
          Container(
            width: 180, height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Outer ring 2
          Container(
            width: 150, height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
          ),
          // Outer ring 1
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFCC1C1C),
            ),
          ),
          // Inner button
          Container(
            width: 96, height: 96,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFB01818),
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }
}
