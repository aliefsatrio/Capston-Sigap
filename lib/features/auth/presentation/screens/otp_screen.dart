import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _secondsRemaining = 44;
  Timer? _timer;
  // false = Email (default), true = WhatsApp
  bool _isWhatsApp = false;

  @override
  void initState() {
    super.initState();
    _controllers[0].text = '4';
    _controllers[1].text = '8';
    _controllers[2].text = '2';
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _timerText {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Top row: back + step indicator + shield
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textPrimary),
                      ),
                    ),
                    const Text(
                      'LANGKAH 2 DARI 3',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Icon(Icons.shield, color: AppColors.redPrimary, size: 22),
                  ],
                ),

                const SizedBox(height: 32),

                // Icon
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.blueSurface2,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.shield_outlined, color: AppColors.bluePrimary, size: 44),
                        Positioned(
                          bottom: 14,
                          right: 14,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: AppColors.redPrimary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Title — changes based on mode
                Center(
                  child: Text(
                    _isWhatsApp ? 'Verifikasi OTP Via Whatsapp' : 'Verifikasi OTP Via Email',
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Description — changes based on mode
                Center(
                  child: Text(
                    _isWhatsApp
                        ? 'Masukkan 6 digit kode OTP yang telah dikirimkan ke nomer 08********'
                        : 'Masukkan 6 digit kode OTP yang telah dikirimkan ke email s****gmail.com',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      color: AppColors.textSecondaryLight,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Edit shortcut link (Capsule button)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.edit, size: 13, color: AppColors.bluePrimary),
                        const SizedBox(width: 6),
                        Text(
                          _isWhatsApp ? 'Nomer' : 'Email',
                          style: const TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 12,
                            color: AppColors.bluePrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // OTP boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (i) => _buildOtpBox(i)),
                ),

                const SizedBox(height: 20),

                // Countdown
                Center(
                  child: Text(
                    '⏰ Kirim ulang kode dalam $_timerText',
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Email / WhatsApp toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isWhatsApp = false),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 15,
                            color: !_isWhatsApp ? AppColors.redPrimary : AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Kirim via  email',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              fontWeight: !_isWhatsApp ? FontWeight.w700 : FontWeight.w400,
                              color: !_isWhatsApp ? AppColors.redPrimary : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('•', style: TextStyle(color: AppColors.textMuted)),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isWhatsApp = true),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 15,
                            color: _isWhatsApp ? const Color(0xFF25D366) : AppColors.textSecondaryLight,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Kirim via WhatsApp',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              fontWeight: _isWhatsApp ? FontWeight.w700 : FontWeight.w400,
                              color: _isWhatsApp ? const Color(0xFF25D366) : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Verifikasi & Lanjutkan button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.push('/gps-activation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redPrimary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Verifikasi & Lanjutkan →',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Privacy panel
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.blueSurface1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shield_outlined, size: 16, color: AppColors.bluePrimary),
                          SizedBox(width: 8),
                          Text(
                            'Jaminan Privasi & Validitas',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.bluePrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'SIGAP menjamin kerahasiaan nomor Anda. Verifikasi nomor seluler diperlukan untuk mencegah laporan palsu (hoax) dan mempercepat respons instansi darurat saat warga membutuhkan bantuan evakuasi.',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12,
                          color: AppColors.textSecondarySlate,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Footer
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '✦ Integrasi Call Center 112',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '🔒 Enkripsi End-to-End',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepBar(bool filled) {
    return Container(
      width: 32,
      height: 4,
      decoration: BoxDecoration(
        color: filled ? AppColors.redPrimary : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    final isActive = index == 3;
    final isPreFilled = index < 3;

    return SizedBox(
      width: 46,
      height: 56,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: isPreFilled ? AppColors.textPrimary : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isActive ? AppColors.redPrimary : const Color(0xFFE2E8F0),
              width: isActive ? 2 : 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isActive ? AppColors.redPrimary : const Color(0xFFE2E8F0),
              width: isActive ? 2 : 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.redPrimary, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (val.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
