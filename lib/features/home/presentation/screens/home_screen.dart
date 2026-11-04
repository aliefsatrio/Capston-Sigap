import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  void _onNavTap(int i) {
    switch (i) {
      case 0: break; // already home
      case 1: context.push('/first-aid'); break;
      case 2: context.push('/camera'); break;
      case 3: context.push('/community'); break;
      case 4: context.push('/history'); break;
    }
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildLocationBar(),
                    _buildEmergencyBanner(),
                    _buildNearbyServices(),
                    _buildEmergencyContact(),
                    _buildSosCard(),
                    _buildReportsSection(),
                    _buildMapPreview(),
                    _buildReportCard1(),
                    _buildReportCard2(),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SigapBottomNav(
        currentIndex: _navIndex,
        onTap: _onNavTap,
        variant: SigapNavVariant.home,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
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
          GestureDetector(
            onTap: () => context.push('/gallery'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.blueSurface1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFBBC4FF)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.dashboard_customize, size: 14, color: AppColors.bluePrimary),
                  SizedBox(width: 4),
                  Text(
                    '16 Layar',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.bluePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: AppColors.bgGrey, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.notifications_outlined, size: 20, color: AppColors.textSecondarySlate),
              ),
              Positioned(
                top: 6, right: 6,
                child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.redPrimary, shape: BoxShape.circle)),
              ),
            ],
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => context.push('/profile'),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFFFDDBB),
              child: const Text('S', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: Color(0xFF7C4A00))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12),
              children: [
                TextSpan(text: 'GPS Aktif (± 3m): ', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.green)),
                TextSpan(text: 'Jl. Pemuda No. 42, Tegal', style: TextStyle(color: AppColors.textSecondarySlate)),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.gps_fixed, size: 16, color: AppColors.bluePrimary),
        ],
      ),
    );
  }

  Widget _buildEmergencyBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.redPrimary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Dalam keadaan darurat?', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                  SizedBox(height: 2),
                  Text('Gunakan fitur darurat berikut untuk memanggil bantuan secepatnya.', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: Colors.white70, height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Layanan Terdekat', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              GestureDetector(
                onTap: () => context.push('/emergency-services'),
                child: const Text('Lihat semua ›', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.bluePrimary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildServiceIcon(Icons.local_police, 'Polisi', '1.2 km', const Color(0xFF0051D5), const Color(0xFFEAEDFF)),
              _buildServiceIcon(Icons.local_fire_department, 'Damkar', '1.5 km', const Color(0xFFE53935), const Color(0xFFFFEBEA)),
              _buildServiceIcon(Icons.local_hospital, 'Rumah\nSakit', '1.8 km', const Color(0xFF059669), const Color(0xFFD1FAE5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(IconData icon, String name, String dist, Color color, Color bg) {
    return Column(
      children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(name, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        Text(dist, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildEmergencyContact() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppColors.blueSurface1, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.person_outline, color: AppColors.bluePrimary, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hubungi Kontak Terdekat', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  SizedBox(height: 2),
                  Text('Orang terdekat Anda siap membantu kapan saja.', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textMuted, height: 1.4), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildSosCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: GestureDetector(
        onTap: () => context.push('/sos'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.redPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.notifications_active, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Tombol Darurat', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                        SizedBox(width: 8),
                        _SosBadge(),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text('Kirim pesan lokasi langsung ke kontak Anda', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: Colors.white70, height: 1.4)),
                  ],
                ),
              ),
              const Icon(Icons.send, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          const Icon(Icons.radar, size: 16, color: AppColors.bluePrimary),
          const SizedBox(width: 6),
          const Text('Laporan Sekitar Anda', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.bgGrey, borderRadius: BorderRadius.circular(100)),
            child: const Text('Radius 3 km', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, color: AppColors.textSecondarySlate)),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPreview() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0FE),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFCFD8DC)),
        ),
        child: Stack(
          children: [
            // Map background
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CustomPaint(size: const Size(double.infinity, 130), painter: _MapPainter()),
            ),
            // Overlay
            Positioned(
              bottom: 10, left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, size: 14, color: AppColors.green),
                    SizedBox(width: 4),
                    Text('3 Laporan Aktif Terverifikasi', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10, right: 10,
              child: GestureDetector(
                onTap: () => context.push('/community'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.bluePrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Buka Peta', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard1() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFFFDDBB),
                    child: Text('B', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: Color(0xFF7C4A00), fontSize: 12)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Budi Santoso', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                        Text('12 menit lalu • 1.2 km dari Anda', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFFFFEBEA), borderRadius: BorderRadius.circular(100)),
                    child: const Text('Kecelakaan', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.redPrimary)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tabrakan Motor vs Mobil di Perempatan Pancasila',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.375),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Lalu lintas padat merayap. Sudah ada petugas Dishub dan medis PMI meluncur ke tempat…',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, color: AppColors.textSecondarySlate, height: 1.43),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Photo
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Container(
                    height: 160,
                    color: const Color(0xFFCFD8DC),
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Color(0xFF90A4AE)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8, left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.redPrimary, borderRadius: BorderRadius.circular(6)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text('Kamera Sigap', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
              child: Row(
                children: [
                  _buildActionBtn(Icons.thumb_up_outlined, '28 Valid', AppColors.green),
                  const SizedBox(width: 10),
                  _buildActionBtn(Icons.thumb_down_outlined, 'Bukan Hoax', AppColors.textSecondarySlate),
                  const Spacer(),
                  const Icon(Icons.share_outlined, size: 18, color: AppColors.textMuted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard2() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFD1FAE5),
                  child: Text('S', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: Color(0xFF059669), fontSize: 12)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Siti Nurhaliza', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      Text('45 menit lalu • 2.4 km dari Anda', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFD1FAE5), borderRadius: BorderRadius.circular(100)),
                  child: const Text('Tertangani', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF059669))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Pohon Tumbang Jl. Gajah Mada Telah Dievakuasi',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.375),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tim Damkar bersama relawan BPBD telah memotong batang pohon yang sempat…',
              style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, color: AppColors.textSecondarySlate, height: 1.43),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.local_fire_department, size: 14, color: AppColors.redBright),
                const SizedBox(width: 4),
                const Text('Damkar Sektor Barat', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, color: AppColors.textSecondarySlate)),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text('Detail info ›', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.bluePrimary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}

class _SosBadge extends StatelessWidget {
  const _SosBadge();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text('SOS', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.redPrimary)),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE8EDF5);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Roads
    final roadPaint = Paint()..color = Colors.white..strokeWidth = 8;
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), roadPaint);

    // Blocks
    final blockPaint = Paint()..color = const Color(0xFFD0D8E8);
    canvas.drawRect(Rect.fromLTWH(10, 10, 100, size.height * 0.4 - 14), blockPaint);
    canvas.drawRect(Rect.fromLTWH(10, size.height * 0.5 + 8, 100, size.height * 0.5 - 18), blockPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.4 + 8, 10, size.width * 0.6 - 18, size.height * 0.4 - 14), blockPaint);

    // Marker
    final markerPaint = Paint()..color = const Color(0xFFE53935);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.5), 10, markerPaint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.5), 7, Paint()..color = Colors.white);

    // User dot
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.3), 20, Paint()..color = AppColors.bluePrimary.withOpacity(0.15));
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.3), 7, Paint()..color = AppColors.bluePrimary);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.3), 4, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
