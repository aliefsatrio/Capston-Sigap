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

  late List<_FeedPost> _posts;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _posts = [
      _FeedPost(
        author: 'Warga Tegal',
        avatarText: 'W',
        avatarBg: const Color(0xFFEAEDFF),
        avatarTextColor: AppColors.bluePrimary,
        timeLocation: '2 jam yang lalu • 1,2 km',
        category: 'Darurat',
        categoryColor: AppColors.redPrimary,
        categoryBg: const Color(0xFFFFEBEA),
        title: 'Kecelakaan di Jl. Pancasila',
        description: 'Terjadi kecelakaan motor dan mobil di Jl. Pancasila arah kota. Mohon hindari jalur ini sementara waktu.',
        hasImage: true,
        likes: 120,
        unlikes: 15,
        reports: 2,
      ),
      _FeedPost(
        author: 'Rizky_07',
        avatarText: 'R',
        avatarBg: const Color(0xFFD1FAE5),
        avatarTextColor: const Color(0xFF059669),
        timeLocation: '4 jam yang lalu • 2,5 km',
        category: 'Bencana',
        categoryColor: const Color(0xFFD97706),
        categoryBg: const Color(0xFFFEF3C7),
        title: 'Banjir di Perumahan Taman Indah',
        description: 'Air sudah mulai naik sekitar 30 cm. Hati-hati yang melintas.',
        hasImage: false,
        likes: 45,
        unlikes: 2,
        reports: 0,
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleLike(int index) {
    setState(() {
      final post = _posts[index];
      if (post.isLiked) {
        post.isLiked = false;
        post.likes--;
      } else {
        post.isLiked = true;
        post.likes++;
        if (post.isUnliked) {
          post.isUnliked = false;
          post.unlikes--;
        }
      }
    });
  }

  void _handleUnlike(int index) {
    setState(() {
      final post = _posts[index];
      if (post.isUnliked) {
        post.isUnliked = false;
        post.unlikes--;
      } else {
        post.isUnliked = true;
        post.unlikes++;
        if (post.isLiked) {
          post.isLiked = false;
          post.likes--;
        }
      }
    });
  }

  void _handleReport(int index) {
    String selectedReason = 'Informasi Palsu / Hoax';
    final reasons = [
      'Informasi Palsu / Hoax',
      'Lokasi Tidak Sesuai',
      'Foto / Bukti Tidak Valid',
      'Spam atau Provokasi',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.report_problem_outlined, color: AppColors.redPrimary, size: 22),
                  const SizedBox(width: 8),
                  const Text(
                    'Laporkan Postingan',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Laporan warga membantu SIGAP memverifikasi keaslian info dan menandai laporan palsu.',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                  color: AppColors.textSecondarySlate,
                ),
              ),
              const SizedBox(height: 16),
              ...reasons.map((r) {
                final isSelected = selectedReason == r;
                return InkWell(
                  onTap: () => setSheetState(() => selectedReason = r),
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isSelected ? AppColors.redPrimary : AppColors.textMuted,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          r,
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    setState(() {
                      final post = _posts[index];
                      post.reports++;
                      post.isReported = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Laporan "$selectedReason" terkirim. Postingan ditandai untuk verifikasi.'),
                        backgroundColor: AppColors.redPrimary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kirim Laporan',
                    style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleShare(int index) {
    final post = _posts[index];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tautan postingan "${post.title}" disalin ke clipboard.'),
        backgroundColor: AppColors.bluePrimary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
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
                if (i == 0) {
                  context.go('/home');
                } else if (i == 1) {
                  context.push('/first-aid');
                } else if (i == 2) {
                  context.push('/camera');
                } else if (i == 4) {
                  context.push('/history');
                }
              },
              variant: SigapNavVariant.home,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedTab() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 90),
      itemCount: _posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (ctx, i) => _buildPostCard(i),
    );
  }

  Widget _buildPostCard(int index) {
    final post = _posts[index];
    final isHoaxSuspected = post.isHoaxSuspected;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: post.avatarBg,
                  child: Text(
                    post.avatarText,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w700,
                      color: post.avatarTextColor,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                      ),
                      Text(
                        post.timeLocation,
                        style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 12, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
                // Badge Status Hoax / Bukan Hoax (menggantikan posisi badge kategori sebelumnya)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isHoaxSuspected ? const Color(0xFFFFEBEA) : const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    isHoaxSuspected ? 'Diduga Hoax' : 'Bukan Hoax',
                    style: TextStyle(
                      fontFamily: 'LiberationSans',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isHoaxSuspected ? const Color(0xFFDC2626) : const Color(0xFF059669),
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Laporkan Postingan',
                  child: GestureDetector(
                    onTap: () => _handleReport(index),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        post.isReported ? Icons.error : Icons.error_outline,
                        size: 22,
                        color: AppColors.redPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Title & Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                Text(
                  post.description,
                  style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 13, color: AppColors.textSecondarySlate, height: 1.5),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Photo preview (if has image)
          if (post.hasImage)
            Container(
              height: 160,
              width: double.infinity,
              color: const Color(0xFF64748B),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.two_wheeler, size: 54, color: Colors.white54),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt, size: 12, color: Colors.white70),
                          SizedBox(width: 4),
                          Text('Foto Kejadian', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Action bar (Hanya Like, Unlike, dan Share)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Row(
              children: [
                // Like Button
                InkWell(
                  onTap: () => _handleLike(index),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          post.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                          size: 18,
                          color: post.isLiked ? AppColors.bluePrimary : AppColors.textSecondarySlate,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${post.likes}',
                          style: TextStyle(
                            fontFamily: 'LiberationSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: post.isLiked ? AppColors.bluePrimary : AppColors.textSecondarySlate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Unlike Button
                InkWell(
                  onTap: () => _handleUnlike(index),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          post.isUnliked ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                          size: 18,
                          color: post.isUnliked ? AppColors.redPrimary : AppColors.textSecondarySlate,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${post.unlikes}',
                          style: TextStyle(
                            fontFamily: 'LiberationSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: post.isUnliked ? AppColors.redPrimary : AppColors.textSecondarySlate,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Share Button
                InkWell(
                  onTap: () => _handleShare(index),
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.share_outlined, size: 20, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          top: 24,
          left: 32,
          right: 32,
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
                    child: Text(
                      f,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textSecondarySlate,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Bottom card
        Positioned(
          bottom: 100,
          left: 32,
          right: 32,
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
                  width: 50,
                  height: 50,
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

class _FeedPost {
  final String author;
  final String avatarText;
  final Color avatarBg;
  final Color avatarTextColor;
  final String timeLocation;
  final String category;
  final Color categoryColor;
  final Color categoryBg;
  final String title;
  final String description;
  final bool hasImage;
  int likes;
  int unlikes;
  int reports;
  bool isLiked;
  bool isUnliked;
  bool isReported;

  _FeedPost({
    required this.author,
    required this.avatarText,
    required this.avatarBg,
    required this.avatarTextColor,
    required this.timeLocation,
    required this.category,
    required this.categoryColor,
    required this.categoryBg,
    required this.title,
    required this.description,
    this.hasImage = false,
    this.likes = 0,
    this.unlikes = 0,
    this.reports = 0,
    this.isLiked = false,
    this.isUnliked = false,
    this.isReported = false,
  });

  bool get isHoaxSuspected => unlikes >= 10 || reports >= 1;
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
