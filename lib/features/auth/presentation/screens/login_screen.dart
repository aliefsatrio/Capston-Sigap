import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title area
                    const Padding(
                      padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Masuk ke SIGAP',
                            style: TextStyle(
                              fontFamily: 'LiberationSans',
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.375,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Selamat datang kembali!',
                            style: TextStyle(
                              fontFamily: 'LiberationSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nomor HP/Email input
                          _buildInput(
                            hint: 'Nomor HP atau Email',
                            icon: Icons.phone_outlined,
                          ),
                          const SizedBox(height: 14),

                          // Password input
                          _buildPasswordInput(),
                          const SizedBox(height: 14),

                          // Ingat saya + Lupa password
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() => _rememberMe = !_rememberMe),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: _rememberMe ? AppColors.bluePrimary : Colors.white,
                                        border: Border.all(
                                          color: _rememberMe ? AppColors.bluePrimary : const Color(0xFFCBD5E1),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: _rememberMe
                                          ? const Icon(Icons.check, size: 12, color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Ingat saya',
                                      style: TextStyle(
                                        fontFamily: 'LiberationSans',
                                        fontSize: 13,
                                        color: AppColors.textSecondaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Lupa password?',
                                  style: TextStyle(
                                    fontFamily: 'LiberationSans',
                                    fontSize: 13,
                                    color: AppColors.bluePrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Masuk button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () => context.go('/home'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bluePrimary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontFamily: 'LiberationSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // atau separator
                          Row(
                            children: [
                              Expanded(child: Container(height: 1, color: const Color(0xFFE2E8F0))),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'atau',
                                  style: TextStyle(
                                    fontFamily: 'LiberationSans',
                                    fontSize: 13,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              Expanded(child: Container(height: 1, color: const Color(0xFFE2E8F0))),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Daftar akun button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: OutlinedButton(
                              onPressed: () => context.push('/register'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.bluePrimary, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: const Text(
                                'Daftar akun',
                                style: TextStyle(
                                  fontFamily: 'LiberationSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.bluePrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Skyline illustration with text
                    _buildSkylineSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({required String hint, required IconData icon}) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'LiberationSans',
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'LiberationSans',
          fontSize: 14,
          color: AppColors.textMuted,
        ),
        prefixIcon: Icon(icon, color: AppColors.textMuted, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.bluePrimary, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      obscureText: _obscurePassword,
      style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, color: AppColors.textMuted),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 20),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscurePassword = !_obscurePassword),
          child: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.textMuted,
            size: 20,
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.bluePrimary, width: 1.5)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildSkylineSection() {
    return Stack(
      children: [
        // Skyline
        Container(
          width: double.infinity,
          height: 160,
          color: const Color(0xFFEAEDFF),
          child: CustomPaint(
            painter: _SkylinePainter(),
          ),
        ),
        // Text overlay
        const Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                'SIGAP selalu ada',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'LiberationSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.bluePrimary,
                ),
              ),
              Text(
                'untuk kamu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'LiberationSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.bluePrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFBBC4FF).withValues(alpha: 0.7);

    final buildings = [
      Rect.fromLTWH(0, size.height * 0.4, 40, size.height * 0.6),
      Rect.fromLTWH(35, size.height * 0.2, 50, size.height * 0.8),
      Rect.fromLTWH(80, size.height * 0.5, 35, size.height * 0.5),
      Rect.fromLTWH(110, size.height * 0.3, 60, size.height * 0.7),
      Rect.fromLTWH(165, size.height * 0.15, 55, size.height * 0.85),
      Rect.fromLTWH(215, size.height * 0.4, 45, size.height * 0.6),
      Rect.fromLTWH(255, size.height * 0.25, 65, size.height * 0.75),
      Rect.fromLTWH(315, size.height * 0.4, 50, size.height * 0.6),
      Rect.fromLTWH(360, size.height * 0.3, 50, size.height * 0.7),
    ];

    for (final b in buildings) {
      canvas.drawRect(b, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
