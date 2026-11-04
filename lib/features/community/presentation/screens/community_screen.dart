import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLavender,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Komunitas',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 14),
                  TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w400),
                    labelColor: AppColors.bluePrimary,
                    unselectedLabelColor: AppColors.textMuted,
                    indicatorColor: AppColors.bluePrimary,
                    indicatorWeight: 2.5,
                    tabs: const [Tab(text: 'Feed'), Tab(text: 'Peta')],
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(),
                  _buildMapTab(),
                ],
              ),
            ),

            SigapBottomNav(
              currentIndex: 3,
              onTap: (i) {
                if (i == 0) context.go('/home');
                else if (i == 2) context.push('/camera');
                else if (i == 4) context.push('/history');
              },
              variant: SigapNavVariant.home,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 90),
      child: Column(
        children: [
          _buildPost1(),
          const SizedBox(height: 14),
          _buildPost2(),
        ],
      ),
    );
  }

  Widget _buildPost1() {
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
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFEAEDFF),
                  child: Text('W', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: AppColors.bluePrimary, fontSize: 13)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Warga Tegal', style: TextStyle(fontFamily: 'LiberationSans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      Text('2 jam yang lalu • 1,2 km', style: TextStyle(fontFamily: 'LiberationSans', fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFFFEBEA), borderRadius: BorderRadius.circular(100)),
                  child: const Text('Darurat', style: TextStyle(fontFamily: 'LiberationSans', fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.redPrimary)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Kecelakaan di Jl. Pancasila',
                    style: TextStyle(fontFamily: 'LiberationSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                SizedBox(height: 6),
                Text(
                  'Terjadi kecelakaan motor dan mobil di Jl. Pancasila arah kota. Mohon hindari jalur ini sementara waktu.',
                  style: TextStyle(fontFamily: 'LiberationSans', fontSize: 13, color: AppColors.textSecondarySlate, height: 1.5),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Photo
          Container(
            height: 150,
            color: const Color(0xFF607D8B),
            child: const Center(child: Icon(Icons.image, size: 48, color: Colors.white38)),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            child: Row(
              children: [
                _buildPostAction(Icons.thumb_up_outlined, '120', AppColors.bluePrimary),
                const SizedBox(width: 14),
                _buildPostAction(Icons.chat_bubble_outline, '15', AppColors.textSecondarySlate),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFF59E0B)),
                    ),
                    child: const Text('Diduga hoax', style: TextStyle(fontFamily: 'LiberationSans', fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF92400E))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPost2() {
    return Container(
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
                radius: 18,
                backgroundColor: Color(0xFFD1FAE5),
                child: Text('R', style: TextStyle(fontFamily: 'PlusJakartaSans', fontWeight: FontWeight.w700, color: Color(0xFF059669), fontSize: 13)),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rizky_07', style: TextStyle(fontFamily: 'LiberationSans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    Text('4 jam yang lalu • 2,5 km', style: TextStyle(fontFamily: 'LiberationSans', fontSize: 12, color: AppColors.textMuted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Banjir di Perumahan Taman Indah',
              style: TextStyle(fontFamily: 'LiberationSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          const Text(
            'Air sudah mulai naik sekitar 30 cm. Hati-hati yang melintas.',
            style: TextStyle(fontFamily: 'LiberationSans', fontSize: 13, color: AppColors.textSecondarySlate, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String count, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(count, style: TextStyle(fontFamily: 'LiberationSans', fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }

  Widget _buildMapTab() {
    return Stack(
      children: [
        // Map background
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 14, 20, 90),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEF5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CustomPaint(painter: _CommunityMapPainter()),
            ),
          ),
        ),

        // Filter pills
        Positioned(
          top: 24, left: 32, right: 32,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Semua', 'Bencana', 'Kecelakaan', 'Lainnya'].map((f) {
                final isSelected = f == 'Semua';
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.bluePrimary : Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)],
                    ),
                    child: Text(f,
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppColors.textSecondarySlate,
                        )),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Bottom card
        Positioned(
          bottom: 100, left: 32, right: 32,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(color: const Color(0xFF607D8B), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.image, color: Colors.white38, size: 24),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Kecelakaan', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.redPrimary)),
                      Text('Jl. Pancasila, Tegal', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      Text('2 jam yang lalu', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CommunityMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = const Color(0xFFE8F0FE));

    // Roads
    final road = Paint()..color = Colors.white..strokeWidth = 10;
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), road);
    canvas.drawLine(Offset(0, size.height * 0.7), Offset(size.width, size.height * 0.7), road);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), road);
    canvas.drawLine(Offset(size.width * 0.65, 0), Offset(size.width * 0.65, size.height), road);

    final block = Paint()..color = const Color(0xFFCFD8DC);
    canvas.drawRect(Rect.fromLTWH(10, 60, size.width * 0.25, size.height * 0.3), block);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, 60, size.width * 0.25, size.height * 0.3), block);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.7, 60, size.width * 0.28, size.height * 0.3), block);

    // Markers
    _drawCircleMarker(canvas, Offset(size.width * 0.2, size.height * 0.4), const Color(0xFFE53935));
    _drawCircleMarker(canvas, Offset(size.width * 0.5, size.height * 0.3), const Color(0xFF2563EB));
    _drawCircleMarker(canvas, Offset(size.width * 0.75, size.height * 0.6), const Color(0xFF10B981));
    _drawCircleMarker(canvas, Offset(size.width * 0.35, size.height * 0.75), const Color(0xFFF59E0B));

    // User
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.55), 25, Paint()..color = AppColors.bluePrimary.withOpacity(0.15));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.55), 10, Paint()..color = AppColors.bluePrimary);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.55), 6, Paint()..color = Colors.white);
  }

  void _drawCircleMarker(Canvas canvas, Offset center, Color color) {
    canvas.drawCircle(center, 14, Paint()..color = color);
    canvas.drawCircle(center, 8, Paint()..color = Colors.white);
    canvas.drawCircle(center, 5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
