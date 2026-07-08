import 'package:crm_app/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            'Subscription',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Manage your corporate billing, plan limits, and usage analytics.',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 18),
                          const _UpgradeButton(),
                          const SizedBox(height: 18),
                          const _CurrentPlanCard(),
                          const SizedBox(height: 16),
                          const _UsageCard(
                            icon: Icons.people_outline,
                            iconColor: AppColors.indigoLight,
                            title: 'Active Users',
                            valueMain: '42',
                            valueSuffix: ' / 50 Seats',
                            progress: 0.84,
                            progressColor: AppColors.indigoLight,
                            caption:
                                '84% of capacity reached. Consider adding seats soon.',
                          ),
                          const SizedBox(height: 16),
                          const _UsageCard(
                            icon: Icons.hub_outlined,
                            iconColor: AppColors.greenAccent,
                            title: 'API Requests',
                            valueMain: '12.4k',
                            valueSuffix: ' / 25k Limit',
                            progress: 0.5,
                            progressColor: AppColors.greenAccent,
                            caption: 'Daily average: 412 requests.',
                          ),
                          const SizedBox(height: 26),
                          Row(
                            children: [
                              const Text(
                                'Billing History',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    'Download All',
                                    style: TextStyle(
                                      color: AppColors.indigoLight,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.file_download_outlined,
                                      color: AppColors.indigoLight, size: 15),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                    const _TableHeader(),
                    const _InvoiceList(),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _EnterpriseCtaCard(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const BottomNav(activeIndex: 4),
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
          const Spacer(),
          const Icon(Icons.notifications_none, color: AppColors.white, size: 24),
          const SizedBox(width: 16),
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.indigoLight,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'AM',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
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
// Upgrade button
// ---------------------------------------------------------------------------
class _UpgradeButton extends StatelessWidget {
  const _UpgradeButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.indigoPale,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_upward, color: AppColors.indigo, size: 17),
                SizedBox(width: 8),
                Text(
                  'Upgrade Plan',
                  style: TextStyle(
                    color: AppColors.indigo,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Current plan card
// ---------------------------------------------------------------------------
class _CurrentPlanCard extends StatelessWidget {
  const _CurrentPlanCard();

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.greenAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'CURRENT PLAN',
                  style: TextStyle(
                    color: AppColors.greenAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'NEXT RENEWAL',
                    style: TextStyle(
                      color: AppColors.textMuted.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Oct 24, 2024',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Premium Enterprise',
            style: TextStyle(
              color: AppColors.indigo,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Comprehensive CRM solutions for large-scale operations.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEDEEF4)),
          const SizedBox(height: 16),
          const _PlanDetailRow(label: 'Billing Cycle', value: 'Annual (Save 20%)'),
          const SizedBox(height: 14),
          const _PlanDetailRow(label: 'Amount', value: '\$1,200.00/yr'),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Method',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
              ),
              const Spacer(),
              const Icon(Icons.credit_card, color: AppColors.indigo, size: 15),
              const SizedBox(width: 6),
              const Text(
                'Visa ending in 8829',
                style: TextStyle(
                  color: AppColors.indigo,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanDetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _PlanDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12.5),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.indigo,
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Usage card (Active Users / API Requests)
// ---------------------------------------------------------------------------
class _UsageCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String valueMain;
  final String valueSuffix;
  final double progress;
  final Color progressColor;
  final String caption;

  const _UsageCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.valueMain,
    required this.valueSuffix,
    required this.progress,
    required this.progressColor,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(icon, color: iconColor, size: 18),
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: valueMain,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: valueSuffix,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: Colors.white.withOpacity(0.08),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            caption,
            style: TextStyle(color: AppColors.textFaint, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Billing history table
// ---------------------------------------------------------------------------
class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cardDarker,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: const [
          Expanded(
            flex: 4,
            child: Text(
              'INVOICE ID',
              style: TextStyle(
                color: AppColors.textFaint,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'DATE',
              style: TextStyle(
                color: AppColors.textFaint,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'AMOUNT',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.textFaint,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Invoice {
  final String id;
  final String date;
  final String amount;
  final bool highlighted;
  const _Invoice(this.id, this.date, this.amount, {this.highlighted = false});
}

class _InvoiceList extends StatelessWidget {
  const _InvoiceList();

  static const invoices = [
    _Invoice('#INV-2023-001', 'Oct 24, 2023', '\$1,200.00'),
    _Invoice('#INV-2022-001', 'Oct 24, 2022', '\$1,200.00', highlighted: true),
    _Invoice('#INV-2021-001', 'Oct 24, 2021', '\$950.00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cardDarker,
      child: Column(
        children: [
          for (int i = 0; i < invoices.length; i++) ...[
            if (i > 0) Divider(height: 1, color: Colors.white.withOpacity(0.06)),
            _InvoiceRow(invoice: invoices[i]),
          ],
        ],
      ),
    );
  }
}

class _InvoiceRow extends StatelessWidget {
  final _Invoice invoice;
  const _InvoiceRow({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: invoice.highlighted
            ? AppColors.indigo.withOpacity(0.12)
            : Colors.transparent,
        border: invoice.highlighted
            ? const Border(left: BorderSide(color: AppColors.indigoLight, width: 3))
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              invoice.id,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              invoice.date,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 12.5),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              invoice.amount,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Enterprise CTA card
// ---------------------------------------------------------------------------
class _EnterpriseCtaCard extends StatelessWidget {
  const _EnterpriseCtaCard();

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
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Need custom enterprise features?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Our team can design bespoke automation flows and high-volume data integrations tailored to your kinetic business needs.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Center(
                        child: Text(
                          'Contact Sales',
                          style: TextStyle(
                            color: AppColors.indigo,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Material(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.35)),
                      ),
                      child: const Center(
                        child: Text(
                          'View Add-ons',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ),
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