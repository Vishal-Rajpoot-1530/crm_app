import 'package:crm_app/theme/app_theme.dart';
import 'package:crm_app/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'OPERATIONAL OVERVIEW',
                      style: TextStyle(
                        color: AppColors.textFaint,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Welcome back, Alex',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _DateChip(),
                    const SizedBox(height: 20),
                    const _StatGrid(),
                    const SizedBox(height: 20),
                    const _QuickActionsCard(),
                    const SizedBox(height: 20),
                    const _RecentActivityCard(),
                    const SizedBox(height: 20),
                    const _TeamPresenceCard(),
                    const SizedBox(height: 20),
                    const _SalesVelocityCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            const BottomNav(activeIndex: 0),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top bar
// ---------------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Row(
        children: [
          const Icon(Icons.menu, color: AppColors.white, size: 22),
          const SizedBox(width: 12),
          const Text(
            'Vibrant CRM',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Icon(Icons.search, color: AppColors.white, size: 22),
          const SizedBox(width: 20),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none,
                  color: AppColors.white, size: 24),
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
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

// ---------------------------------------------------------------------------
// Date chip
// ---------------------------------------------------------------------------
class _DateChip extends StatelessWidget {
  const _DateChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.calendar_today_outlined,
              color: AppColors.greenAccent, size: 16),
          SizedBox(width: 10),
          Text(
            'October 24, 2023',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat grid (2x2)
// ---------------------------------------------------------------------------
class _StatGrid extends StatelessWidget {
  const _StatGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.bar_chart_rounded,
                iconBg: AppColors.purpleIcon,
                accentColor: AppColors.purpleIcon,
                topRight: '+12%',
                topRightColor: AppColors.greenAccent,
                label: 'Active Leads',
                value: '1,284',
              ),
            ),
            Container(
              width: 1,
              height: 96,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white.withOpacity(0.06),
            ),
            Expanded(
              child: _StatCard(
                icon: Icons.check_box_outlined,
                iconBg: AppColors.blueIcon,
                accentColor: AppColors.blueIcon,
                topRight: '8/12',
                topRightColor: AppColors.textMuted,
                label: 'Tasks for Today',
                value: '04 Left',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.person_outline,
                iconBg: AppColors.greenIcon,
                accentColor: AppColors.greenAccent,
                topRight: 'Optimal',
                topRightColor: AppColors.greenAccent,
                label: 'Attendance %',
                value: '96.8%',
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: _StatCard(
                icon: Icons.credit_card,
                iconBg: AppColors.cyanIcon,
                accentColor: AppColors.indigo,
                topRight: '+\$4k',
                topRightColor: AppColors.greenAccent,
                label: 'Monthly Revenue',
                value: '\$42.5k',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color accentColor;
  final String topRight;
  final Color topRightColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.accentColor,
    required this.topRight,
    required this.topRightColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: accentColor, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconBg.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: iconBg, size: 18),
              ),
              const Spacer(),
              Text(
                topRight,
                style: TextStyle(
                  color: topRightColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared white card wrapper
// ---------------------------------------------------------------------------
class _WhiteCard extends StatelessWidget {
  final Widget child;
  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Quick actions
// ---------------------------------------------------------------------------
class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard();

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: AppColors.slate,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _ActionButton(
            icon: Icons.person_add_alt_1_outlined,
            label: 'Add Lead',
            color: AppColors.indigo,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ActionButton(
            icon: Icons.description_outlined,
            label: 'Create Task',
            color: const Color(0xFF3A4066),
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _ActionButton(
            icon: Icons.fact_check_outlined,
            label: 'Log Attendance',
            color: const Color(0xFF0E8F5E),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, color: AppColors.white, size: 17),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recent activity
// ---------------------------------------------------------------------------
class _ActivityItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String boldPart;
  final String subtitle;
  final String badge;
  final Color badgeColor;

  const _ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.boldPart,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
  });
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard();

  static const items = [
    _ActivityItem(
      icon: Icons.person_outline,
      iconColor: AppColors.indigo,
      boldPart: 'Jordan Smith',
      title: ' converted a lead to a client.',
      subtitle: '2 minutes ago • Real Estate Portfolio',
      badge: 'SUCCESS',
      badgeColor: AppColors.success,
    ),
    _ActivityItem(
      icon: Icons.assignment_outlined,
      iconColor: AppColors.blueIcon,
      boldPart: 'Task Expired:',
      title: ' Follow-up with Peterson Group.',
      subtitle: '45 minutes ago • High Priority',
      badge: 'EXPIRED',
      badgeColor: AppColors.expired,
    ),
    _ActivityItem(
      icon: Icons.attach_money,
      iconColor: AppColors.greenAccent,
      boldPart: 'Payment Received:',
      title: ' \$2,400 from Zen Corp.',
      subtitle: '2 hours ago • Invoice #8841',
      badge: 'PAYMENT',
      badgeColor: AppColors.payment,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  color: AppColors.slate,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                'View All',
                style: TextStyle(
                  color: AppColors.indigo,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: Color(0xFFF0F1F5)),
            _ActivityRow(item: items[i]),
          ],
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final _ActivityItem item;
  const _ActivityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: item.iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color(0xFF20233A),
                      fontSize: 13.5,
                    ),
                    children: [
                      TextSpan(
                        text: item.boldPart,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: item.title),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item.badgeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.badge,
              style: TextStyle(
                color: item.badgeColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Team presence
// ---------------------------------------------------------------------------
class _TeamMember {
  final String name;
  final Color statusColor;
  const _TeamMember(this.name, this.statusColor);
}

class _TeamPresenceCard extends StatelessWidget {
  const _TeamPresenceCard();

  static const members = [
    _TeamMember('Sarah Jenkins', AppColors.greenAccent),
    _TeamMember('Marcus Thorne', AppColors.greenAccent),
    _TeamMember('Lila Vance', AppColors.textFaint),
  ];

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Team Presence',
            style: TextStyle(
              color: AppColors.slate,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          for (final m in members) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.indigo.withOpacity(0.15),
                    child: Text(
                      m.name[0],
                      style: const TextStyle(
                        color: AppColors.indigo,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    m.name,
                    style: const TextStyle(
                      color: Color(0xFF3A4066),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: m.statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE3E5EE)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Manage Team',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sales velocity
// ---------------------------------------------------------------------------
class _SalesVelocityCard extends StatelessWidget {
  const _SalesVelocityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A3FE0), Color(0xFF3350D6)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Velocity',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'October Target: \$50,000',
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Text(
                'Progress',
                style: TextStyle(color: AppColors.white, fontSize: 12.5),
              ),
              Spacer(),
              Text(
                '85%',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.85,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.greenAccent),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "\"You're \$7.5k away from your monthly bonus!\"",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}