import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const bg = Color(0xFF0A0F1E);
  static const textSecondary = Color(0xFF9599B3);
  static const cardBorder = Color(0xFF232840);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 24),
                  _buildGreeting(),
                  const SizedBox(height: 22),
                  _buildActionsRow(),
                  const SizedBox(height: 22),
                  _buildStatsRow(),
                  const SizedBox(height: 28),
                  const Text(
                    'Modules',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildModulesGrid(),
                  const SizedBox(height: 28),
                  _buildRecentHeader(),
                  const SizedBox(height: 18),
                  _buildActivityList(),
                ],
              ),
            ),
            Positioned(bottom: 24, right: 0, child: _buildFab()),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.menu, color: Color(0xFFCFD3E0), size: 24),
            const SizedBox(width: 14),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: 'CRM\n'),
                  TextSpan(
                    text: 'Enterprise',
                    style: TextStyle(color: Color(0xFF8B8FC7)),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.search, color: Color(0xFFCFD3E0), size: 22),
            const SizedBox(width: 18),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: Color(0xFFCFD3E0),
                  size: 22,
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0526B),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 18),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6F6FF0), width: 2),
                color: const Color(0xFF20233A),
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFFCFD3E0),
                size: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning, Vishal',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Here is what's happening with your accounts today.",
          style: TextStyle(fontSize: 14, color: textSecondary),
        ),
      ],
    );
  }

  Widget _buildActionsRow() {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _actionButton(
            icon: Icons.person_add_alt_1,
            label: 'Add Customer',
            primary: true,
          ),
          const SizedBox(width: 10),
          _actionButton(icon: Icons.edit_note, label: 'Create Task'),
          const SizedBox(width: 10),
          _actionButton(
            icon: Icons.file_download_outlined,
            label: 'Import Leads',
          ),
          const SizedBox(width: 10),
          _actionButton(icon: Icons.receipt_long, label: 'New Invoice'),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    bool primary = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: primary ? const Color(0xFF6C63F5) : const Color(0xFF171C30),
        borderRadius: BorderRadius.circular(24),
        border: primary
            ? null
            : Border.all(color: const Color(0xFF2A2F47), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: primary ? Colors.white : const Color(0xFFE2E4EE),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: primary ? Colors.white : const Color(0xFFE2E4EE),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return SizedBox(
      height: 138,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 155,
            child: _statCard(
              label: 'CUSTOMERS',
              value: '1,284',
              borderColor: const Color.fromARGB(255, 123, 121, 248),
              trendIcon: Icons.trending_up,
              trendText: '+12%',
              trendColor: const Color(0xFF4ADE80),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 155,
            child: _statCard(
              label: 'ACTIVE PROJECTS',
              value: '48',
              borderColor: const Color.fromARGB(255, 78, 146, 241),
              trendIcon: Icons.arrow_forward,
              trendText: '0%',
              trendColor: textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 155,
            child: _statCard(
              label: 'REVENUE',
              value: '\$82.4k',
              borderColor: const Color(0xFF2FAE82),
              trendIcon: Icons.trending_up,
              trendText: '+8%',
              trendColor: const Color(0xFF4ADE80),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 155,
            child: _statCard(
              label: 'PENDING',
              value: '23',
              borderColor: const Color(0xFFD9A52C),
              trendIcon: Icons.trending_down,
              trendText: '-3%',
              trendColor: const Color(0xFFE0526B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String label,
    required String value,
    required Color borderColor,
    required IconData trendIcon,
    required String trendText,
    required Color trendColor,
  }) {
    const radius = 16.0;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.fromLTRB(19, 16, 16, 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2437),
              borderRadius: BorderRadius.circular(radius),
              border: Border(
                left: BorderSide(
                  color: borderColor,
                  width: 4, // Thicker left border
                ),
                top: BorderSide(color: borderColor, width: 1),
                right: BorderSide(color: borderColor, width: 1),
                bottom: BorderSide(color: borderColor, width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.bold,
                    color: textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(trendIcon, size: 14, color: trendColor),
                    const SizedBox(width: 5),
                    Text(
                      trendText,
                      style: TextStyle(fontSize: 12.5, color: trendColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModulesGrid() {
    final modules = [
      _ModuleData(
        icon: Icons.people_alt,
        iconBg: const Color(0xFF1B2340),
        iconColor: const Color(0xFFCFD3E0),
        count: '1.2k',
        countBg: const Color(0xFF171C30),
        countColor: const Color(0xFFCFD3E0),
        title: 'Customers',
        desc: 'Manage relationships...',
        borderColor: const Color(0xFF5A54C9),
      ),
      _ModuleData(
        icon: Icons.work,
        iconBg: const Color(0xFF123D31),
        iconColor: const Color(0xFF3FD39A),
        count: '850',
        countBg: const Color(0xFF10241D),
        countColor: const Color(0xFF3FD39A),
        title: 'Employees',
        desc: 'HR, payroll, and internal...',
        borderColor: const Color(0xFF2FAE82),
      ),
      _ModuleData(
        icon: Icons.bar_chart,
        iconBg: const Color(0xFF1B2340),
        iconColor: const Color(0xFFCFD3E0),
        count: '342',
        countBg: const Color(0xFF171C30),
        countColor: const Color(0xFFCFD3E0),
        title: 'Leads',
        desc: 'Pipeline and potential sales.',
        borderColor: const Color(0xFF3F7FE0),
      ),
      _ModuleData(
        icon: Icons.check_circle,
        iconBg: const Color(0xFF1B2340),
        iconColor: const Color(0xFFCFD3E0),
        count: '12',
        countBg: const Color(0xFF171C30),
        countColor: const Color(0xFFCFD3E0),
        title: 'Tasks',
        desc: 'Project deliverables...',
        borderColor: const Color(0xFF8B5CE0),
      ),
      _ModuleData(
        icon: Icons.event_available,
        iconBg: const Color(0xFF123D31),
        iconColor: const Color(0xFF3FD39A),
        count: '94%',
        countBg: const Color(0xFF10241D),
        countColor: const Color(0xFF3FD39A),
        title: 'Attendance',
        desc: 'Staff clock-in and leave...',
        borderColor: const Color(0xFF2FAE82),
      ),
      _ModuleData(
        icon: Icons.receipt_long,
        iconBg: const Color(0xFF1B2340),
        iconColor: const Color(0xFFCFD3E0),
        count: '5 Pending',
        countBg: const Color(0xFF171C30),
        countColor: const Color(0xFFCFD3E0),
        title: 'Invoices',
        desc: 'Billing and transaction...',
        borderColor: const Color(0xFFD9A52C),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modules.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, index) => _moduleCard(modules[index]),
    );
  }

  Widget _moduleCard(_ModuleData m) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2437),
        borderRadius: BorderRadius.circular(18),
        border: Border(
          left: BorderSide(color: m.borderColor, width: 4),
          top: BorderSide(color: m.borderColor, width: .5),
          right: BorderSide(color: m.borderColor, width: .5),
          bottom: BorderSide(color: m.borderColor, width: .5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: m.iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: m.icon != null
                    ? Icon(m.icon, color: m.iconColor, size: 19)
                    : null,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: m.countBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    m.count,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: m.countColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            m.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            m.desc,
            style: const TextStyle(
              fontSize: 13,
              color: textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'View All',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B8FC7),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    final items = [
      _ActivityData(
        icon: Icons.person,
        dotColor: const Color(0xFF6C63F5),
        title: 'New Customer Registered',
        time: '10m ago',
        desc: 'Acme Corp added by Vishal as a Priority Lead.',
      ),
      _ActivityData(
        icon: Icons.check,
        dotColor: const Color(0xFF1FAE7A),
        title: 'Task Completed',
        time: '2h ago',
        desc: 'Cloud Migration Phase 1 marked as resolved.',
      ),
      _ActivityData(
        icon: Icons.trending_up,
        dotColor: const Color.fromARGB(255, 124, 141, 229),
        iconColor: const Color.fromARGB(255, 250, 251, 255),
        title: 'Sales Milestone',
        time: 'Yesterday',
        desc: 'Monthly revenue target reached 85% of goal.',
      ),
    ];

    return Stack(
      children: [
        Positioned(
          left: 14,
          top: 14,
          bottom: 14,
          child: Container(width: 1.5, color: cardBorder),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 34),
          child: Column(
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _activityItem(item),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _activityItem(_ActivityData a) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -34,
          top: 30,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: a.dotColor,
              shape: BoxShape.circle,
              border: Border.all(color: bg, width: 3),
            ),
            child: Icon(a.icon, size: 14, color: a.iconColor ?? Colors.white),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(19, 14, 16, 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2437),
                  border: Border(
                    left: BorderSide(color: a.dotColor, width: 4),
                    top: BorderSide(color: a.dotColor, width: .5),
                    right: BorderSide(color: a.dotColor, width: .5),
                    bottom: BorderSide(color: a.dotColor, width: .5),
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            a.title,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          a.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      a.desc,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFFB3B6CB),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 4, color: a.dotColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFab() {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF2FAE82),
        borderRadius: BorderRadius.circular(26),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 18, color: Color(0xFF06251B)),
          SizedBox(width: 8),
          Text(
            'NEW ACTION',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF06251B),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleData {
  final IconData? icon;
  final Color iconBg;
  final Color iconColor;
  final String count;
  final Color countBg;
  final Color countColor;
  final String title;
  final String desc;
  final Color borderColor;

  _ModuleData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.count,
    required this.countBg,
    required this.countColor,
    required this.title,
    required this.desc,
    required this.borderColor,
  });
}

class _ActivityData {
  final IconData icon;
  final Color dotColor;
  final Color? iconColor;
  final String title;
  final String time;
  final String desc;

  _ActivityData({
    required this.icon,
    required this.dotColor,
    this.iconColor,
    required this.title,
    required this.time,
    required this.desc,
  });
}
