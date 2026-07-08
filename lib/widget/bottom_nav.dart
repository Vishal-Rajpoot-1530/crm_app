import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
 

class NavItem {
  final IconData icon;
  final String label;
  const NavItem(this.icon, this.label);
}

/// Bottom navigation bar shared by every screen.
/// Pass [activeIndex] to highlight the current tab, [items] to override
/// the default tab set (screens can show different combinations), and
/// [onTap] to hook up real navigation (defaults to a no-op).
class BottomNav extends StatelessWidget {
  static const defaultItems = [
    NavItem(Icons.grid_view_rounded, 'Dashboard'),
    NavItem(Icons.people_alt_outlined, 'Leads'),
    NavItem(Icons.credit_card, 'Payments'),
    NavItem(Icons.receipt_long_outlined, 'Expenses'),
    NavItem(Icons.person_outline, 'Profile'),
  ];

  final int activeIndex;
  final List<NavItem> items;
  final ValueChanged<int>? onTap;

  const BottomNav({
    super.key,
    required this.activeIndex,
    this.items = defaultItems,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardDarker,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < items.length; i++)
            GestureDetector(
              onTap: () => onTap?.call(i),
              behavior: HitTestBehavior.opaque,
              child: _NavButton(item: items[i], active: i == activeIndex),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavItem item;
  final bool active;
  const _NavButton({required this.item, required this.active});

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.indigoLight : AppColors.textFaint;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (active)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.indigo.withOpacity(0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, color: color, size: 20),
          )
        else
          Icon(item.icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          item.label,
          style: TextStyle(
            color: color,
            fontSize: 10.5,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}