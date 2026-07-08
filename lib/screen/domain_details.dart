import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// COMPANY PROFILE SCREEN ("Kinetic Global Solutions")
/// Self-contained — run directly or import `CompanyProfileScreen`.
/// -----------------------------------------------------------------------

 

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
      home: const CompanyProfileScreen(),
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
  static const statCard = Color(0xFFD9DCF6);
}

/// ---------------------------- MODELS --------------------------------------
enum DomainStatus { verified, expiring }

extension DomainStatusX on DomainStatus {
  String get label => this == DomainStatus.verified ? 'VERIFIED' : 'EXPIRING';
  Color get color => this == DomainStatus.verified ? AppColors.success : AppColors.danger;
}

class Domain {
  final String name;
  final String type;
  final DomainStatus status;
  final String provider;
  final String renewDate;

  const Domain({
    required this.name,
    required this.type,
    required this.status,
    required this.provider,
    required this.renewDate,
  });
}

class Leader {
  final String name;
  final String role;
  final Color avatarColor;
  const Leader(this.name, this.role, this.avatarColor);
}

/// ---------------------------- SCREEN --------------------------------------
class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  final List<Domain> _domains = const [
    Domain(
      name: 'kinetic-global.com',
      type: 'Primary Corporate',
      status: DomainStatus.verified,
      provider: 'Route 53',
      renewDate: 'Oct 12 2025',
    ),
    Domain(
      name: 'kinetic-ops.io',
      type: 'Internal Platform',
      status: DomainStatus.verified,
      provider: 'Google Domains',
      renewDate: 'Jan 05 2025',
    ),
    Domain(
      name: 'kinetic-staging.net',
      type: 'Legacy Staging',
      status: DomainStatus.expiring,
      provider: 'GoDaddy',
      renewDate: 'Mar 14 2024',
    ),
  ];

  final List<Leader> _leaders = const [
    Leader('David Chen', 'Global Director', Color(0xFF4A6FE0)),
    Leader('Sarah Jenkins', 'Domain Strategist', Color(0xFFE07A9E)),
    Leader('Elena Rodriguez', 'Compliance Officer', Color(0xFF6C8CF5)),
  ];

  int _navIndex = 3; // Profile tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            _Dot(color: AppColors.success),
                            SizedBox(width: 6),
                            Text(
                              'Active Enterprise',
                              style: TextStyle(color: AppColors.success, fontSize: 11.5, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Kinetic Global Solutions',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Unified Infrastructure & Domain Governance',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(color: AppColors.border),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Edit Profile', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              icon: const Icon(Icons.add_rounded, size: 16),
                              label: const Text('Manage Domains', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _BrandIdentityCard(),
                      const SizedBox(height: 16),
                      _HeadquartersCard(),
                      const SizedBox(height: 16),
                      _DomainEcosystemCard(domains: _domains),
                      const SizedBox(height: 16),
                      _AccountLeadershipCard(leaders: _leaders),
                      const SizedBox(height: 16),
                      _UptimeStatCard(),
                      const SizedBox(height: 8),
                    ],
                  ),
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

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// ---------------------------- TOP BAR --------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 6),
      child: Row(
        children: [
          const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Vibrant CRM',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primary,
            child: Text('AM', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

/// A rounded bordered panel used throughout the screen.
class _Panel extends StatelessWidget {
  final Widget child;
  const _Panel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _PanelHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;

  const _PanelHeader({required this.icon, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: AppColors.textPrimary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        if (trailing != null)
          Text(trailing!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

/// ---------------------------- BRAND IDENTITY --------------------------------
class _BrandIdentityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.hub_rounded, color: AppColors.primary, size: 30),
          ),
          const SizedBox(height: 14),
          const Text(
            'Brand Identity',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 15.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kinetic Global Solutions operates as a decentralized autonomous entity providing high-performance logistics and tech infrastructure. Registered in Delaware, USA, with global hubs in London and Singapore.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoChip(label: 'EIN/TAX ID', value: '88-2940291-K'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoChip(label: 'ESTABLISHED', value: 'Oct 2018'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.3)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

/// ---------------------------- HEADQUARTERS --------------------------------
class _HeadquartersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PanelHeader(icon: Icons.description_outlined, title: 'Headquarters'),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.location_on_outlined,
            label: 'Primary Address',
            value: '101 Kinetic Plaza, Suite 400\nWilmington, DE 19801',
          ),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.call_outlined,
            label: 'Support Hotline',
            value: '+1 (800) 555-KINETIC',
          ),
          const SizedBox(height: 16),
          _ContactRow(
            icon: Icons.mail_outline_rounded,
            label: 'Admin Email',
            value: 'admin@kinetic-global.com',
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(9)),
          child: Icon(icon, size: 16, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
              const SizedBox(height: 3),
              Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w600, height: 1.35)),
            ],
          ),
        ),
      ],
    );
  }
}

/// ---------------------------- DOMAIN ECOSYSTEM --------------------------------
class _DomainEcosystemCard extends StatelessWidget {
  final List<Domain> domains;
  const _DomainEcosystemCard({required this.domains});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PanelHeader(
            icon: Icons.hub_outlined,
            title: 'Domain Ecosystem',
            trailing: '${domains.length} Domains Total',
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(flex: 3, child: Text('DOMAIN NAME', style: TextStyle(color: AppColors.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.3))),
              Expanded(flex: 2, child: Text('STATUS', style: TextStyle(color: AppColors.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.3))),
              Expanded(flex: 2, child: Text('PROVIDER', style: TextStyle(color: AppColors.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.3))),
              Expanded(flex: 2, child: Text('RENEW', style: TextStyle(color: AppColors.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.3))),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.border, height: 1),
          ...domains.map((d) => _DomainRow(domain: d)),
        ],
      ),
    );
  }
}

class _DomainRow extends StatelessWidget {
  final Domain domain;
  const _DomainRow({required this.domain});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: domain.status.color, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(domain.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(domain.type, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10.5)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: domain.status.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  domain.status.label,
                  style: TextStyle(color: domain.status.color, fontSize: 9, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(domain.provider, style: const TextStyle(color: AppColors.textPrimary, fontSize: 11.5)),
          ),
          Expanded(
            flex: 2,
            child: Text(domain.renewDate, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10.5)),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------- ACCOUNT LEADERSHIP --------------------------------
class _AccountLeadershipCard extends StatelessWidget {
  final List<Leader> leaders;
  const _AccountLeadershipCard({required this.leaders});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PanelHeader(icon: Icons.shield_outlined, title: 'Account Leadership'),
          const SizedBox(height: 14),
          ...leaders.map(
            (l) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: l.avatarColor,
                      child: Text(
                        l.name.trim().split(' ').map((s) => s[0]).take(2).join(),
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l.name, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(l.role, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5)),
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.chat_bubble_outline_rounded, size: 14, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: DottedBorderBox(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: Text(
                    'Assign New Stakeholder',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple dashed-border container built with CustomPainter (no package dep).
class DottedBorderBox extends StatelessWidget {
  final Widget child;
  const DottedBorderBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DashedBorderPainter(), child: child);
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    final path = Path()..addRRect(rrect);
    const dashWidth = 6.0;
    const dashSpace = 5.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ---------------------------- UPTIME STAT CARD --------------------------------
class _UptimeStatCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.statCard,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      '98.4%',
                      style: TextStyle(color: AppColors.success, fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'GLOBAL UPTIME',
                      style: TextStyle(color: Color(0xFF5B5F72), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.4),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '18ms',
                      style: TextStyle(color: const Color(0xFF1A1D2E).withOpacity(0.35), fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AVG DNS LATENCY',
                      style: TextStyle(color: const Color(0xFF5B5F72).withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 8,
          bottom: -8,
          child: Material(
            color: AppColors.primary,
            shape: const CircleBorder(),
            elevation: 4,
            child: InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: const SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
              ),
            ),
          ),
        ),
      ],
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
    (icon: Icons.checklist_rtl_outlined, activeIcon: Icons.checklist_rtl_rounded, label: 'Tasks'),
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
            if (selected) {
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item.activeIcon, color: Colors.white, size: 20),
                      const SizedBox(height: 3),
                      Text(item.label, style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, color: AppColors.textSecondary, size: 20),
                  const SizedBox(height: 3),
                  Text(item.label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 9.5, fontWeight: FontWeight.w600)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}