import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0A0E1A);
  static const card = Color(0xFFFFFFFF);
  static const purple = Color(0xFF5B4FE8);
  static const green = Color(0xFF12A150);
  static const greenSoft = Color(0x1F12A150);
  static const red = Color(0xFF8E1B2E);
  static const redText = Color(0xFFE0687A);
  static const peach = Color(0xFFE07A5F);
  static const chipBg = Color(0x14FFFFFF);
  static const textDark = Color(0xFF15182B);
  static const textGrey = Color(0xFF9AA0AE);
  static const tagBg = Color(0xFFEFF1F6);
  static const tagText = Color(0xFF3C4257);
}

// ---------------------------------------------------------------------------
// DATA MODELS
// ---------------------------------------------------------------------------
enum MemberStatus { active, onLeave }

class TeamMember {
  final String name;
  final String role;
  final List<String> tags;
  final MemberStatus status;
  final String footerText;
  final IconData footerIcon;
  final Color avatarColor;
  final bool showAvatarStack;
  const TeamMember({
    required this.name,
    required this.role,
    required this.tags,
    required this.status,
    required this.footerText,
    required this.footerIcon,
    required this.avatarColor,
    this.showAvatarStack = false,
  });
}

// ---------------------------------------------------------------------------
// SCREEN
// ---------------------------------------------------------------------------
class TeamDirectoryScreen extends StatefulWidget {
  const TeamDirectoryScreen({super.key});

  @override
  State<TeamDirectoryScreen> createState() => _TeamDirectoryScreenState();
}

class _TeamDirectoryScreenState extends State<TeamDirectoryScreen> {
  int _navIndex = 1; // Team tab active
  int _selectedFilter = 0;
  final _searchController = TextEditingController();

  final List<String> _filters = const [
    'All Departments',
    'Engineering',
    'Design',
    'Sales',
    'Marketing',
  ];

  final List<TeamMember> _members = const [
    TeamMember(
      name: 'Jordan Vance',
      role: 'Senior Developer',
      tags: ['React', 'Node.js'],
      status: MemberStatus.active,
      footerText: '',
      footerIcon: Icons.circle,
      avatarColor: Color(0xFF6B7280),
      showAvatarStack: true,
    ),
    TeamMember(
      name: 'Maya Ishii',
      role: 'Lead UI/UX Designer',
      tags: ['Figma', 'Design Ops'],
      status: MemberStatus.active,
      footerText: 'Available now',
      footerIcon: Icons.access_time,
      avatarColor: Color(0xFFB08968),
    ),
    TeamMember(
      name: 'Daniel Grant',
      role: 'Project Manager',
      tags: ['Agile', 'Scrum'],
      status: MemberStatus.onLeave,
      footerText: 'Back in 3 days',
      footerIcon: Icons.event_outlined,
      avatarColor: Color(0xFF8B95A8),
    ),
    TeamMember(
      name: 'Sasha Blake',
      role: 'Growth Lead',
      tags: ['SEO', 'Analytics'],
      status: MemberStatus.active,
      footerText: 'In a meeting',
      footerIcon: Icons.call_outlined,
      avatarColor: Color(0xFFD4A574),
    ),
    TeamMember(
      name: 'Marcus Thorne',
      role: 'Cloud Architect',
      tags: ['AWS', 'Security'],
      status: MemberStatus.active,
      footerText: 'Message',
      footerIcon: Icons.mail_outline,
      avatarColor: Color(0xFF5C6B8A),
    ),
    TeamMember(
      name: 'Elena Costa',
      role: 'Account Manager',
      tags: ['Sales', 'CRM'],
      status: MemberStatus.active,
      footerText: 'Available',
      footerIcon: Icons.access_time,
      avatarColor: Color(0xFF7A8B6F),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 18),
                  _buildStatsRow(),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 14),
                ],
              ),
            ),
            _buildFilterChips(),
            const SizedBox(height: 14),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  for (final m in _members) ...[
                    _buildMemberCard(m),
                    const SizedBox(height: 12),
                  ],
                  _buildAddMemberCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ---------------------------------------------------------------------
  // APP BAR
  // ---------------------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: const Text(
        'Vibrant CRM',
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.peach,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------
  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Directory',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Manage your organization's core talent and track live status.",
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 13,
            height: 1.35,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _statCard('TOTAL', '124', Colors.white)),
        const SizedBox(width: 10),
        Expanded(child: _statCard('ACTIVE', '118', AppColors.green)),
        const SizedBox(width: 10),
        Expanded(child: _statCard('AWAY', '6', AppColors.redText)),
      ],
    );
  }

  Widget _statCard(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x14FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x14FFFFFF)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textGrey, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                hintText: 'Search employees, roles, or skills...',
                hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 13.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = i == _selectedFilter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? AppColors.purple : AppColors.chipBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isActive
                      ? Colors.transparent
                      : const Color(0x1FFFFFFF),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (i == 0) ...[
                    const Icon(Icons.tune, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    _filters[i],
                    style: TextStyle(
                      color: isActive ? Colors.white : AppColors.textGrey,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------
  // MEMBER CARD
  // ---------------------------------------------------------------------
  Widget _buildMemberCard(TeamMember m) {
    final isOnLeave = m.status == MemberStatus.onLeave;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: m.avatarColor,
                child: Text(
                  m.name.trim().split(' ').map((e) => e[0]).take(2).join(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.name,
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      m.role,
                      style: const TextStyle(
                        color: AppColors.purple,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _statusBadge(isOnLeave),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: m.tags.map((t) => _tagChip(t)).toList()),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEDEEF2)),
          const SizedBox(height: 10),
          Row(
            children: [
              if (m.showAvatarStack)
                _buildMiniAvatarStack()
              else ...[
                Icon(m.footerIcon, size: 15, color: AppColors.textGrey),
                const SizedBox(width: 6),
                Text(
                  m.footerText,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textGrey,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(bool isOnLeave) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOnLeave ? AppColors.red : AppColors.greenSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOnLeave ? 'ON LEAVE' : 'ACTIVE',
        style: TextStyle(
          color: isOnLeave ? Colors.white : AppColors.green,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _tagChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.tagBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.tagText,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMiniAvatarStack() {
    final colors = [
      const Color(0xFFB0B7C3),
      const Color(0xFF8B95A8),
      const Color(0xFF5B4FE8),
    ];
    return SizedBox(
      width: 56,
      height: 22,
      child: Stack(
        children: List.generate(colors.length, (i) {
          return Positioned(
            left: i * 16.0,
            child: CircleAvatar(
              radius: 11,
              backgroundColor: Colors.white,
              child: CircleAvatar(radius: 9.5, backgroundColor: colors[i]),
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // ADD MEMBER CARD
  // ---------------------------------------------------------------------
  Widget _buildAddMemberCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0x33FFFFFF),
          style: BorderStyle.solid,
          width: 1.4,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.purple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_add_alt_1,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Add Member',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Scale your team further.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 12.5),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // BOTTOM NAV
  // ---------------------------------------------------------------------
  // Widget _buildBottomNav() {
  //   final items = [
  //     (Icons.dashboard_outlined, 'Dashboard'),
  //     (Icons.groups_outlined, 'Team'),
  //     (Icons.check_box_outlined, 'Tasks'),
  //     (Icons.calendar_today_outlined, 'Schedule'),
  //     (Icons.person_outline, 'Profile'),
  //   ];

  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: AppColors.bg,
  //       border: Border(top: BorderSide(color: Color(0x1FFFFFFF))),
  //     ),
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: SafeArea(
  //       top: false,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: List.generate(items.length, (i) {
  //           final isActive = i == _navIndex;
  //           final (icon, label) = items[i];
  //           return GestureDetector(
  //             onTap: () => setState(() => _navIndex = i),
  //             child: isActive
  //                 ? Container(
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 14, vertical: 6),
  //                     decoration: BoxDecoration(
  //                       color: AppColors.purple,
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Icon(icon, color: Colors.white, size: 20),
  //                         const SizedBox(height: 2),
  //                         Text(label,
  //                             style: const TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 10,
  //                                 fontWeight: FontWeight.w600)),
  //                       ],
  //                     ),
  //                   )
  //                 : Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Icon(icon, color: AppColors.textGrey, size: 20),
  //                       const SizedBox(height: 4),
  //                       Text(label,
  //                           style: const TextStyle(
  //                               color: AppColors.textGrey, fontSize: 10)),
  //                     ],
  //                   ),
  //           );
  //         }),
  //       ),
  //     ),
  //   );
  // }
}
