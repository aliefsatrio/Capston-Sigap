import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class FirstAidScreen extends StatelessWidget {
  const FirstAidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('SIGAP', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.bluePrimary)),
                      Text('Beranda', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                  const Spacer(),
                  Stack(children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.bgGrey, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.notifications_outlined, size: 20, color: AppColors.textSecondarySlate),
                    ),
                    Positioned(top: 6, right: 6, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.redPrimary, shape: BoxShape.circle))),
                  ]),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => context.push('/profile'),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFFFDDBB),
                      child: Text('S', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: Color(0xFF7C4A00))),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Assistant Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: AppColors.blueSurface1, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.smart_toy_outlined, color: AppColors.bluePrimary, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('SIGAP AI Assistant', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: AppColors.redPrimary, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('112', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Text('Siap Siaga 24 Jam • Respon Medis Cepat',
                                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textMuted)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Ambulance status
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_hospital, color: Color(0xFF059669), size: 18),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Ambulans PMI Tegal terkoordinasi',
                                style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF059669))),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: const Color(0xFF059669), borderRadius: BorderRadius.circular(100)),
                            child: const Text('~6 Menit', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Topics
                    Row(
                      children: [
                        const Expanded(
                          child: Text('TOPIK DARURAT MEDIS CEPAT (P3K)',
                              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                        ),
                        const Text('Geser', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.bluePrimary)),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, size: 14, color: AppColors.bluePrimary),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildTopic('Pendarahan Hebat', true),
                          _buildTopic('Resusitasi Jantung (CPR)', false),
                          _buildTopic('Patah Tulang', false),
                          _buildTopic('Korban Tidak Sadar', false),
                          _buildTopic('Keracunan / Sengatan', false),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Chat area
                    // Initial bot message
                    _buildBotMessage(
                      'Halo! Saya asisten P3K SIGAP. Tenang, bantuan medis dapat dipandu sekarang. Jelaskan kondisi korban, ketik keluhan, atau tekan tombol suara untuk pesan suara darurat.',
                      '09:40 WIB • Terbaca',
                    ),

                    const SizedBox(height: 10),

                    // Voice message bubble
                    _buildVoiceMessage(),

                    const SizedBox(height: 14),

                    // Guidance card
                    _buildGuidanceCard(),

                    const SizedBox(height: 14),

                    // Composer
                    _buildComposer(),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),

            SigapBottomNav(
              currentIndex: 1,
              onTap: (i) {
                if (i == 0) context.go('/home');
                else if (i == 2) context.push('/camera');
                else if (i == 3) context.push('/community');
                else if (i == 4) context.push('/history');
              },
              variant: SigapNavVariant.home,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopic(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.redPrimary : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: isActive ? AppColors.redPrimary : const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isActive) ...[
              const Icon(Icons.check, size: 12, color: Colors.white),
              const SizedBox(width: 4),
            ],
            Text(label, style: TextStyle(
              fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.textSecondarySlate,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildBotMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: AppColors.blueSurface1, shape: BoxShape.circle),
            child: const Icon(Icons.smart_toy_outlined, color: AppColors.bluePrimary, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(text, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textPrimary, height: 1.5)),
                ),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 280,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.bluePrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 8),
                    // Waveform
                    Expanded(
                      child: Row(
                        children: List.generate(20, (i) {
                          final h = [4.0, 8.0, 12.0, 16.0, 20.0, 14.0, 10.0, 18.0, 6.0, 22.0,
                            16.0, 12.0, 20.0, 8.0, 14.0, 18.0, 10.0, 16.0, 6.0, 12.0][i];
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              height: h,
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(2)),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('0:14', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                  child: const Text('TRANSKRIP SUARA OTOMATIS',
                      style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white70)),
                ),
                const SizedBox(height: 6),
                const Text(
                  '"Tolong! Korban kecelakaan motor tergeletak di tepi jalan, tidak sadar dan ada pendarahan cukup deras di lengan kanan."',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: Colors.white, height: 1.5),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 12, color: Colors.white70),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text('Jl. Pancasila No. 12 (Akurasi GPS 3m)',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: Colors.white70)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text('09:41 WIB • Terkirim', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildGuidanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.redSurface1, borderRadius: BorderRadius.circular(6)),
                  child: const Text('Tindakan Darurat Prioritas 1', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.redPrimary)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.blueSurface1, borderRadius: BorderRadius.circular(6)),
                  child: const Text('Langkah Medis Lapangan', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.bluePrimary)),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Panduan Tanggap: Korban Tak Sadar & Pendarahan Lengan',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 14),
          _buildStep(1, 'Amankan & Jangan Gerakkan Leher',
              'Pastikan posisi aman dari arus lalu lintas. Jangan memindahkan leher atau punggung jika dicurigai cedera benturan tulang belakang.'),
          _buildStep(2, 'Tekan Kuat Titik Pendarahan',
              'Gunakan kain bersih, perban, atau pakaian tebal. Tekan terus-menerus tepat di atas luka. Jangan lepas tekanan sampai petugas medis tiba.'),
          _buildStep(3, 'Cek Jalan Napas & Denyut Nadi',
              'Dekatkan pipi ke hidung korban selama 10 detik. Jika napas terhenti, mulailah kompresi dada (CPR 100-120x per menit).'),
          Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.volume_up_outlined, size: 16),
                label: const Text('Dengarkan Instruksi Suara (Voice Assistant)',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bluePrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  elevation: 0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: const [
                Icon(Icons.access_time, size: 12, color: AppColors.textMuted),
                SizedBox(width: 4),
                Text('Baru saja • Berdasarkan protokol medis PMI & Kemkes',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int number, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24, height: 24,
            decoration: const BoxDecoration(color: AppColors.redPrimary, shape: BoxShape.circle),
            child: Center(
              child: Text('$number', style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondarySlate, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(Icons.image_outlined, size: 18, color: AppColors.textMuted),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Ketik gejala atau situasi...',
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, color: AppColors.textMuted)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(color: AppColors.redPrimary, shape: BoxShape.circle),
              child: const Icon(Icons.mic, color: Colors.white, size: 22),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Tahan ikon Mikrofon untuk rekam suara darurat langsung ke petugas.',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
