import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sigap_bottom_nav.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
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
                  const Text('Riwayat & Statistik',
                      style: TextStyle(fontFamily: 'LiberationSans', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 14),
                  TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: const TextStyle(fontFamily: 'LiberationSans', fontSize: 14, fontWeight: FontWeight.w400),
                    labelColor: AppColors.bluePrimary,
                    unselectedLabelColor: AppColors.textMuted,
                    indicatorColor: AppColors.bluePrimary,
                    indicatorWeight: 2.5,
                    tabs: const [Tab(text: 'Riwayat'), Tab(text: 'Statistik')],
                  ),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRiwayatTab(),
                  _buildStatistikTab(),
                ],
              ),
            ),

            SigapBottomNav(
              currentIndex: 4,
              onTap: (i) {
                if (i == 0) {
                  context.go('/home');
                // ignore: curly_braces_in_flow_control_structures
                } else if (i == 1) context.push('/first-aid');
                // ignore: curly_braces_in_flow_control_structures
                else if (i == 2) context.push('/camera');
                // ignore: curly_braces_in_flow_control_structures
                else if (i == 3) context.push('/community');
              },
              variant: SigapNavVariant.home,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiwayatTab() {
    return const Center(
      child: Text(
        'Belum ada riwayat laporan.\n(Tab Riwayat - tidak ada desain referensi)',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 14, color: AppColors.textMuted),
      ),
    );
  }

  Widget _buildStatistikTab() {
    // Data: Jun 12, Jul 15, Agt 18, Sep 20, Okt 16, Nov 14
    final chartData = [
      _ChartBar(month: 'Jun', value: 12),
      _ChartBar(month: 'Jul', value: 15),
      _ChartBar(month: 'Agt', value: 18),
      _ChartBar(month: 'Sep', value: 20),
      _ChartBar(month: 'Okt', value: 16),
      _ChartBar(month: 'Nov', value: 14),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jumlah Kejadian per Bulan',
                    style: TextStyle(fontFamily: 'LiberationSans', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: chartData.map((d) => _buildBar(d, maxVal: 20)).toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lokasi Kejadian',
                    style: TextStyle(fontFamily: 'LiberationSans', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 14),
                _buildLocationRow('Jl. Pancasila', '8 kejadian'),
                _buildDivider(),
                // NOTE: "5 keig lalu" is a typo in the original Figma. Preserved as-is per spec.
                _buildLocationRow('Jl. Melati', '5 keig lalu'),
                _buildDivider(),
                _buildLocationRow('Jl. Sudirman', '4 kejadian'),
                _buildDivider(),
                _buildLocationRow('Perum. Taman Indah', '3 kejadian'),
                _buildDivider(),
                _buildLocationRow('Lainnya', '2 kejadian'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(_ChartBar data, {required int maxVal}) {
    final heightFraction = data.value / maxVal;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${data.value}',
          style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 4),
        Container(
          width: 36,
          height: 110 * heightFraction,
          decoration: const BoxDecoration(
            color: AppColors.bluePrimary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 6),
        Text(data.month, style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildLocationRow(String location, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on, size: 16, color: AppColors.redPrimary),
          const SizedBox(width: 8),
          Expanded(child: Text(location, style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 13, color: AppColors.textPrimary))),
          Text(count, style: const TextStyle(fontFamily: 'LiberationSans', fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildDivider() => Container(height: 1, color: const Color(0xFFF1F5F9));
}

class _ChartBar {
  final String month;
  final int value;
  _ChartBar({required this.month, required this.value});
}
