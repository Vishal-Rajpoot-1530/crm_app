import 'package:crm_app/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
 

class LeadDetailScreen extends StatelessWidget {
  const LeadDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    const _Breadcrumb(),
                    const SizedBox(height: 10),
                    const _HeaderBlock(),
                    const SizedBox(height: 18),
                    const _VictoryMilestoneCard(),
                    const SizedBox(height: 16),
                    const _ConversionMetricsCard(),
                    const SizedBox(height: 16),
                    const _PrimaryContactCard(),
                    const SizedBox(height: 16),
                    const _DealSquadCard(),
                    const SizedBox(height: 16),
                    const _JourneyCard(),
                    const SizedBox(height: 22),
                    const Text(
                      'Contract Documentation',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const _DocumentCard(
                      icon: Icons.description_outlined,
                      name: 'Final_MSA.pdf',
                      subtitle: '2.1 MB • Signed',
                    ),
                    const SizedBox(height: 10),
                    const _DocumentCard(
                      icon: Icons.grid_on,
                      name: 'Pricing_Tiers.xlsx',
                      subtitle: '512 KB • Approved',
                    ),
                    const SizedBox(height: 10),
                    const _DocumentCard(
                      icon: Icons.verified_outlined,
                      name: 'Service_Level.pdf',
                      subtitle: '340 KB • Active',
                    ),
                    const SizedBox(height: 10),
                    const _AddDocumentCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            const BottomNav(activeIndex: 1),
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
  const _TopBar();

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
          const Icon(Icons.search, color: AppColors.white, size: 21),
          const SizedBox(width: 18),
          const Icon(Icons.notifications_none, color: AppColors.white, size: 23),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Breadcrumb + header
// ---------------------------------------------------------------------------
class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Leads',
          style: TextStyle(color: AppColors.textFaint, fontSize: 12.5),
        ),
        Text(
          '  >  ',
          style: TextStyle(color: AppColors.textFaint, fontSize: 12.5),
        ),
        Text(
          'Global Logistics Corp',
          style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
        ),
      ],
    );
  }
}

class _HeaderBlock extends StatelessWidget {
  const _HeaderBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                'Global Logistics Corp',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.greenAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: AppColors.greenAccent, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'WON',
                    style: TextStyle(
                      color: AppColors.greenAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Enterprise Supply Chain Solution • Closed on Oct 24, 2023',
          style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Victory milestone
// ---------------------------------------------------------------------------
class _VictoryMilestoneCard extends StatelessWidget {
  const _VictoryMilestoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.greenAccent.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greenAccent.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.greenAccent.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events, color: AppColors.greenAccent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VICTORY MILESTONE',
                  style: TextStyle(
                    color: AppColors.greenAccent,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Quarter Lead Winner',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+12.5% vs. Annual Target',
                  style: TextStyle(color: AppColors.greenAccent, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Conversion metrics
// ---------------------------------------------------------------------------
class _ConversionMetricsCard extends StatelessWidget {
  const _ConversionMetricsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conversion Metrics',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Performance breakdown of the sales cycle',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    '\$425,000',
                    style: TextStyle(
                      color: AppColors.greenAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'TOTAL CONTRACT VALUE',
                    style: TextStyle(
                      color: AppColors.textFaint,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _MetricTile(
                  label: 'CYCLES',
                  value: '42 Days',
                  caption: '15% Faster',
                  captionIcon: Icons.trending_down,
                  captionColor: AppColors.greenAccent,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MetricTile(
                  label: 'TOUCHPOINTS',
                  value: '18 Items',
                  caption: 'Multi-channel',
                  captionColor: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Expanded(
                child: _MetricTile(
                  label: 'PROBABILITY',
                  value: '100%',
                  caption: 'Target Reached',
                  captionColor: AppColors.greenAccent,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MetricTile(
                  label: 'MARGIN',
                  value: '24.2%',
                  caption: '+2.1% High',
                  captionIcon: Icons.trending_up,
                  captionColor: AppColors.greenAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final String caption;
  final Color captionColor;
  final IconData? captionIcon;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.caption,
    required this.captionColor,
    this.captionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textFaint,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (captionIcon != null) ...[
                Icon(captionIcon, color: captionColor, size: 12),
                const SizedBox(width: 3),
              ],
              Text(
                caption,
                style: TextStyle(color: captionColor, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Primary contact
// ---------------------------------------------------------------------------
class _PrimaryContactCard extends StatelessWidget {
  const _PrimaryContactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Primary Contact',
            style: TextStyle(
              color: AppColors.slate,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.slate.withOpacity(0.15),
                child: const Text(
                  'SH',
                  style: TextStyle(
                    color: AppColors.slate,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sarah Hyland',
                    style: TextStyle(
                      color: Color(0xFF20233A),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'VP of Operations',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _ContactRow(icon: Icons.mail_outline, text: 's.hyland@globallogistics.com'),
          const SizedBox(height: 10),
          const _ContactRow(icon: Icons.call_outlined, text: '+1 (555) 012-3456'),
          const SizedBox(height: 10),
          const _ContactRow(icon: Icons.location_on_outlined, text: 'San Francisco, CA'),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: Material(
              color: AppColors.indigoPale,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.rocket_launch_outlined, color: AppColors.indigo, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Launch Meeting',
                        style: TextStyle(
                          color: AppColors.indigo,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
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

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textMuted, size: 16),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF3A4066), fontSize: 13),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Deal squad
// ---------------------------------------------------------------------------
class _SquadMember {
  final String name;
  final String role;
  final String badge;
  final Color badgeColor;
  const _SquadMember(this.name, this.role, this.badge, this.badgeColor);
}

class _DealSquadCard extends StatelessWidget {
  const _DealSquadCard();

  static const members = [
    _SquadMember('David Chen', 'Account Executive', 'LEAD', AppColors.greenAccent),
    _SquadMember('Elena Rodriguez', 'Solutions Architect', 'SUPPORT', AppColors.textMuted),
    _SquadMember('Marcus Thorne', 'Legal Counsel', 'COMPLIANCE', AppColors.textMuted),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deal Squad',
            style: TextStyle(
              color: AppColors.white,
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
                    radius: 18,
                    backgroundColor: AppColors.indigo.withOpacity(0.2),
                    child: Text(
                      m.name.split(' ').map((w) => w[0]).take(2).join(),
                      style: const TextStyle(
                        color: AppColors.indigoLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
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
                            color: AppColors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          m.role,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: m.badgeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      m.badge,
                      style: TextStyle(
                        color: m.badgeColor,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Journey to won
// ---------------------------------------------------------------------------
class _JourneyStep {
  final String title;
  final String caption;
  final Color dotColor;
  const _JourneyStep(this.title, this.caption, this.dotColor);
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard();

  static const steps = [
    _JourneyStep('Contract Signed', 'Oct 24 • Final proposal accepted by Board',
        AppColors.greenAccent),
    _JourneyStep('Legal Review Finished', 'Oct 18 • MSA and SLA documentation cleared',
        AppColors.indigoLight),
    _JourneyStep('Technical Validation', 'Sept 29 • Successfully completed 2-week PoC',
        AppColors.textFaint),
    _JourneyStep('Inbound Discovery', 'Sept 12 • Initial inquiry via Enterprise portal',
        AppColors.textFaint),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Journey to Won',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                'Full Audit',
                style: TextStyle(
                  color: AppColors.indigoLight,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          for (int i = 0; i < steps.length; i++)
            _JourneyRow(step: steps[i], isLast: i == steps.length - 1),
        ],
      ),
    );
  }
}

class _JourneyRow extends StatelessWidget {
  final _JourneyStep step;
  final bool isLast;
  const _JourneyRow({required this.step, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(color: step.dotColor, shape: BoxShape.circle),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    step.caption,
                    style: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Document cards
// ---------------------------------------------------------------------------
class _DocumentCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String subtitle;
  const _DocumentCard({required this.icon, required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.textMuted, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3), size: 18),
        ],
      ),
    );
  }
}

class _AddDocumentCard extends StatelessWidget {
  const _AddDocumentCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: AppColors.textMuted, size: 18),
              const SizedBox(width: 8),
              Text(
                'Add Document',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}