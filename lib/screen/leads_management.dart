import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// LEAD MANAGEMENT SCREEN
/// Drop `LeadManagementScreen` into any MaterialApp. No external packages
/// required — everything uses core Flutter + Material Icons.
/// -----------------------------------------------------------------------

void main() => runApp(const CrmApp());

class CrmApp extends StatelessWidget {
  const CrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
      ),
      home: const LeadManagementScreen(),
    );
  }
}

/// ---------------------------- COLORS ------------------------------------
class AppColors {
  static const background = Color(0xFF0A0E17);
  static const surface = Color(0xFF12172A);
  static const surfaceAlt = Color(0xFF171D33);
  static const border = Color(0xFF232A42);
  static const primary = Color(0xFF7C6DF2);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF8A90A6);
  static const success = Color(0xFF2ED47A);
  static const danger = Color(0xFFE2536B);
  static const gold = Color(0xFFE0B84B);
}

/// ---------------------------- MODELS --------------------------------------
enum LeadStatus { newLead, inProgress, won, lost }

extension LeadStatusX on LeadStatus {
  String get label {
    switch (this) {
      case LeadStatus.newLead:
        return 'NEW';
      case LeadStatus.inProgress:
        return 'IN PROGRESS';
      case LeadStatus.won:
        return 'WON';
      case LeadStatus.lost:
        return 'LOST';
    }
  }

  Color get color {
    switch (this) {
      case LeadStatus.newLead:
        return AppColors.success;
      case LeadStatus.inProgress:
        return const Color(0xFF6C8CF5);
      case LeadStatus.won:
        return AppColors.success;
      case LeadStatus.lost:
        return AppColors.danger;
    }
  }

  IconData get icon {
    switch (this) {
      case LeadStatus.newLead:
        return Icons.bolt_rounded;
      case LeadStatus.inProgress:
        return Icons.assignment_outlined;
      case LeadStatus.won:
        return Icons.shopping_bag_outlined;
      case LeadStatus.lost:
        return Icons.lock_outline_rounded;
    }
  }
}

class Lead {
  final String company;
  final String contact;
  final double value;
  final LeadStatus status;

  const Lead({
    required this.company,
    required this.contact,
    required this.value,
    required this.status,
  });
}

/// ---------------------------- SCREEN --------------------------------------
class LeadManagementScreen extends StatefulWidget {
  const LeadManagementScreen({super.key});

  @override
  State<LeadManagementScreen> createState() => _LeadManagementScreenState();
}

class _LeadManagementScreenState extends State<LeadManagementScreen> {
  final List<Lead> _leads = const [
    Lead(
      company: 'TechNova Solutions',
      contact: 'Sarah Jenkins',
      value: 42500,
      status: LeadStatus.inProgress,
    ),
    Lead(
      company: 'BuildRight Inc.',
      contact: 'Robert Chen',
      value: 128000,
      status: LeadStatus.newLead,
    ),
    Lead(
      company: 'GreenLife Retail',
      contact: 'Elena Rodriguez',
      value: 15200,
      status: LeadStatus.won,
    ),
    Lead(
      company: 'SkyHigh Aviation',
      contact: 'Marcus Webb',
      value: 220000,
      status: LeadStatus.lost,
    ),
    Lead(
      company: 'Global Finance Ltd.',
      contact: 'William Thorne',
      value: 74800,
      status: LeadStatus.inProgress,
    ),
  ];

  int _selectedFilter = 0; // 0 = New, 1 = In Progress, 2 = Won
  final _filters = const ['New', 'In Progress', 'Won'];
  int _navIndex = 1; // Leads tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Lead Management',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Track and optimize your sales pipeline',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _CreateLeadButton(onTap: () {}),
                  const SizedBox(height: 16),
                  _SearchBar(),
                  const SizedBox(height: 16),
                  _FilterChips(
                    filters: _filters,
                    selectedIndex: _selectedFilter,
                    onSelected: (i) => setState(() => _selectedFilter = i),
                  ),
                  const SizedBox(height: 20),
                  ..._leads.map(
                    (lead) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _LeadCard(lead: lead),
                    ),
                  ),
                  const SizedBox(height: 4),
                  _AddCustomLeadCard(onTap: () {}),
                  const SizedBox(height: 20),
                  _SalesMomentumCard(),
                  const SizedBox(height: 20),
                  _GrowthInsightCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        selectedIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

/// ---------------------------- TOP BAR --------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
          Row(
            children: [
              const Icon(Icons.search_rounded, color: AppColors.textPrimary),
              const SizedBox(width: 18),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.textPrimary,
                  ),
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.danger,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 18),
              const CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primary,
                child: Text(
                  'AM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------- CREATE LEAD BUTTON ---------------------------
class _CreateLeadButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CreateLeadButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text(
          'Create New Lead',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// ---------------------------- SEARCH BAR ------------------------------------
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search by lead name, company or value',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------- FILTER CHIPS ----------------------------------
class _FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _FilterChips({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(filters.length, (i) {
        final selected = i == selectedIndex;
        return Padding(
          padding: EdgeInsets.only(right: i == filters.length - 1 ? 0 : 10),
          child: GestureDetector(
            onTap: () => onSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// ---------------------------- LEAD CARD ---------------------------------
class _LeadCard extends StatelessWidget {
  final Lead lead;
  const _LeadCard({required this.lead});

  String _formatValue(double v) {
    final s = v.toStringAsFixed(0);
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buf.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buf.write(',');
    }
    return '\$$buf';
  }

  @override
  Widget build(BuildContext context) {
    final status = lead.status;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: status.color, width: 3),
          top: const BorderSide(color: AppColors.border),
          right: const BorderSide(color: AppColors.border),
          bottom: const BorderSide(color: AppColors.border),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(status.icon, color: AppColors.textPrimary, size: 20),
              ),
              _StatusBadge(status: status),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            lead.company,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Contact: ${lead.contact}',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 10),
          Text(
            'Value: ${_formatValue(lead.value)}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _LeadActionButton(
                  icon: Icons.call_outlined,
                  label: 'Call',
                  filled: true,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LeadActionButton(
                  icon: Icons.mail_outline_rounded,
                  label: 'Email',
                  filled: false,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final LeadStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: status.color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _LeadActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _LeadActionButton({
    required this.icon,
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: filled ? AppColors.primary : Colors.transparent,
          foregroundColor: Colors.white,
          side: BorderSide(
            color: filled ? AppColors.primary : AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

/// ---------------------------- ADD CUSTOM LEAD -----------------------------
class _AddCustomLeadCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AddCustomLeadCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: DottedBorderBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceAlt,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add_rounded, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 10),
              const Text(
                'Add Custom Lead',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Manually enter lead details for a custom\nclient opportunity.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple dashed-border container built from a CustomPainter so no external
/// package is needed.
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path = Path()..addRRect(rrect);
    const dashWidth = 6.0;
    const dashSpace = 5.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ---------------------------- SALES MOMENTUM CARD --------------------------
class _SalesMomentumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.35),
            AppColors.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Momentum',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your pipeline value has increased by 22% this month. Keep pushing towards your quarterly goals.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      r'$1.2M',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'TOTAL PIPELINE VALUE',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '84%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'CONVERSION VELOCITY',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------- GROWTH INSIGHT CARD ---------------------------
class _GrowthInsightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.success,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(Icons.show_chart_rounded, color: Colors.black, size: 18),
          ),
          const SizedBox(height: 12),
          const Text(
            'Growth Insight',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Leads from the 'Technology' sector are converting 3x faster than traditional manufacturing. Prioritize Sarah Jenkins' follow-up.",
            style: TextStyle(color: Colors.black87, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Analyze Sector Performance',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------- BOTTOM NAV ------------------------------------
class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.selectedIndex, required this.onTap});

  static const _items = [
    (icon: Icons.dashboard_outlined, activeIcon: Icons.dashboard_rounded, label: 'Dashboard'),
    (icon: Icons.people_outline_rounded, activeIcon: Icons.people_alt_rounded, label: 'Leads'),
    (icon: Icons.trending_up_rounded, activeIcon: Icons.trending_up_rounded, label: 'Sales'),
    (icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart_rounded, label: 'Reports'),
    (icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final item = _items[i];
            final selected = i == selectedIndex;
            final color = selected ? AppColors.primary : AppColors.textSecondary;
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(selected ? item.activeIcon : item.icon, color: color, size: 22),
                  const SizedBox(height: 3),
                  Text(
                    item.label,
                    style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}