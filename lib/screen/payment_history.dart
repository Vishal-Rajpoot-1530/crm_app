import 'package:crm_app/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  int _filterIndex = 0; // 0 = All Payments, 1 = Paid, 2 = Pending

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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _RevenueCard(),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _NextPayoutCard(),
                    ),
                    const SizedBox(height: 20),
                    _FilterBar(
                      selected: _filterIndex,
                      onSelect: (i) => setState(() => _filterIndex = i),
                    ),
                    const _TableHeader(),
                    const _TransactionList(),
                    const _FooterCount(),
                  ],
                ),
              ),
            ),
            const BottomNav(activeIndex: 2),
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
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          const Icon(Icons.menu, color: AppColors.white, size: 22),
          const SizedBox(width: 16),
          const Text(
            'Payment History',
            style: TextStyle(
              color: AppColors.indigoPale,
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
// Total revenue card
// ---------------------------------------------------------------------------
class _RevenueCard extends StatelessWidget {
  const _RevenueCard();

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
            'TOTAL REVENUE (Q3)',
            style: TextStyle(
              color: AppColors.textFaint,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '\$142,850.00',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.greenAccent, size: 16),
              const SizedBox(width: 6),
              const Text(
                '+12.5%',
                style: TextStyle(
                  color: AppColors.greenAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'vs last quarter',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
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
// Next payout card
// ---------------------------------------------------------------------------
class _NextPayoutCard extends StatelessWidget {
  const _NextPayoutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.indigoPale,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEXT PAYOUT DATE',
            style: TextStyle(
              color: AppColors.indigo.withOpacity(0.85),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Oct 24, 2024',
            style: TextStyle(
              color: Color(0xFF20244A),
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Auto-scheduled for Midnight',
            style: TextStyle(
              color: const Color(0xFF20244A).withOpacity(0.65),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
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
                      'Manage',
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
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

// ---------------------------------------------------------------------------
// Filter bar (segmented control + export)
// ---------------------------------------------------------------------------
class _FilterBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _FilterBar({required this.selected, required this.onSelect});

  static const labels = ['All Payments', 'Paid', 'Pending'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (int i = 0; i < labels.length; i++) ...[
                _FilterChip(
                  label: labels[i],
                  active: selected == i,
                  onTap: () => onSelect(i),
                ),
                const SizedBox(width: 10),
              ],
              const Spacer(),
              const Icon(Icons.calendar_today_outlined,
                  color: AppColors.textMuted, size: 15),
              const SizedBox(width: 4),
              const Text(
                'Date Range',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Material(
            color: AppColors.indigoPale.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_outlined,
                        color: AppColors.indigo, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Export',
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? AppColors.indigo : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Text(
            label,
            style: TextStyle(
              color: active ? AppColors.white : AppColors.textMuted,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Table header
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
            flex: 3,
            child: Text(
              'REFERENCE ID',
              style: TextStyle(
                color: AppColors.textFaint,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'TRANSACTION',
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

// ---------------------------------------------------------------------------
// Transaction list
// ---------------------------------------------------------------------------
class _Transaction {
  final String refId;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String date;

  const _Transaction({
    required this.refId,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.date,
  });
}

class _TransactionList extends StatelessWidget {
  const _TransactionList();

  static const transactions = [
    _Transaction(
      refId: '#PAY-9928-XA',
      icon: Icons.person_outline,
      iconColor: AppColors.greenIcon,
      title: 'Client Payment: Arca Tech',
      subtitle: 'Project Milestone 2',
      date: 'Oct 12, 2024',
    ),
    _Transaction(
      refId: '#SAL-4410-BC',
      icon: Icons.work_outline,
      iconColor: AppColors.indigo,
      title: 'Monthly Salary',
      subtitle: 'Payroll Disbursement',
      date: 'Oct 05, 2024',
    ),
    _Transaction(
      refId: '#INV-7732-KL',
      icon: Icons.description_outlined,
      iconColor: Color(0xFF232849),
      title: 'Software Licensing',
      subtitle: 'Azure Enterprise Suite',
      date: 'Oct 02, 2024',
    ),
    _Transaction(
      refId: '#PAY-8821-MM',
      icon: Icons.person_outline,
      iconColor: AppColors.greenIcon,
      title: 'Client Payment: Nexus Corp',
      subtitle: 'Consultancy Retainer',
      date: 'Sep 28, 2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        children: [
          for (int i = 0; i < transactions.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: Color(0xFFF0F1F5)),
            _TransactionRow(t: transactions[i]),
          ],
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final _Transaction t;
  const _TransactionRow({required this.t});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              t.refId,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: t.iconColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(t.icon, color: AppColors.white, size: 17),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.title,
                        style: const TextStyle(
                          color: AppColors.indigo,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        t.subtitle,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              t.date,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer count
// ---------------------------------------------------------------------------
class _FooterCount extends StatelessWidget {
  const _FooterCount();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cardDarker,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: const Text(
        'Showing 1 to 4 of 124 transactions',
        style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
      ),
    );
  }
}