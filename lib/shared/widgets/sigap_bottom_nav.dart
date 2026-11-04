import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Komponen Bottom Navigation Bar reusable SIGAP
/// Mendukung beberapa varian sesuai desain Figma
enum SigapNavVariant {
  home,         // Beranda, P3K/Bot, +Lapor, Komunitas, Riwayat
  services,     // Beranda, Lapor, Komunitas, Riwayat, Profil
}

class SigapBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final SigapNavVariant variant;

  const SigapBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.variant = SigapNavVariant.home,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: variant == SigapNavVariant.home
            ? _buildHomeNavItems()
            : _buildServicesNavItems(),
      ),
    );
  }

  List<Widget> _buildHomeNavItems() {
    // Beranda, P3K/Bot, +Lapor (center), Komunitas, Riwayat
    final items = [
      _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Beranda', index: 0),
      _NavItem(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'P3K/Bot', index: 1),
      null, // center lapor button
      _NavItem(icon: Icons.people_outline, activeIcon: Icons.people, label: 'Komunitas', index: 3),
      _NavItem(icon: Icons.history_outlined, activeIcon: Icons.history, label: 'Riwayat', index: 4),
    ];

    return [
      _buildNavItemWidget(items[0]!, currentIndex, onTap),
      _buildNavItemWidget(items[1]!, currentIndex, onTap),
      _buildCenterLaporButton(onTap),
      _buildNavItemWidget(items[3]!, currentIndex, onTap),
      _buildNavItemWidget(items[4]!, currentIndex, onTap),
    ];
  }

  List<Widget> _buildServicesNavItems() {
    // Beranda, Lapor, Komunitas, Riwayat, Profil
    final items = [
      _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Beranda', index: 0),
      null, // center lapor
      _NavItem(icon: Icons.people_outline, activeIcon: Icons.people, label: 'Komunitas', index: 2),
      _NavItem(icon: Icons.history_outlined, activeIcon: Icons.history, label: 'Riwayat', index: 3),
      _NavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profil', index: 4),
    ];

    return [
      _buildNavItemWidget(items[0]!, currentIndex, onTap),
      _buildCenterLaporButton(onTap),
      _buildNavItemWidget(items[2]!, currentIndex, onTap),
      _buildNavItemWidget(items[3]!, currentIndex, onTap),
      _buildNavItemWidget(items[4]!, currentIndex, onTap),
    ];
  }

  static Widget _buildNavItemWidget(_NavItem item, int currentIndex, ValueChanged<int> onTap) {
    final isActive = currentIndex == item.index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(item.index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              size: 24,
              color: isActive ? AppColors.bluePrimary : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.bluePrimary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCenterLaporButton(ValueChanged<int> onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(2),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.redPrimary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.redPrimary.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 2),
            const Text(
              '+ Lapor',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.redPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;

  _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
  });
}
