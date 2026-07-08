// import 'package:crm_app/screen/attendance_history.dart';
import 'package:crm_app/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:crm_app/theme/app_theme.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

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
                      padding: EdgeInsets.fromLTRB(20, 4, 20, 0),
                      child: _Header(),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _SpendingBreakdownCard(),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _BudgetStatusCard(),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _MiniStatsRow(),
                    ),
                    const SizedBox(height: 26),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Recent Expense Reports',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: _FilterRow(),
                    ),
                    const SizedBox(height: 16),
                    const _TableHeader(),
                    const _ReportsList(),
                    const _FooterPager(),
                  ],
                ),
              ),
            ),
            const BottomNav(activeIndex: 3),
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
          const SizedBox(width: 14),
          const Text(
            'Vibrant CRM',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.notifications_none,
            color: AppColors.white,
            size: 24,
          ),
          const SizedBox(width: 16),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
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
// Header
// ---------------------------------------------------------------------------
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Company Expenses',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Overview of organizational spending and approval status.',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Spending breakdown (donut chart)
// ---------------------------------------------------------------------------
class _ExpenseSlice {
  final String label;
  final double amount;
  final Color color;
  const _ExpenseSlice(this.label, this.amount, this.color);
}

class _SpendingBreakdownCard extends StatelessWidget {
  const _SpendingBreakdownCard();

  static const slices = [
    _ExpenseSlice('Travel', 17000, AppColors.blueIcon),
    _ExpenseSlice('Equipment', 14875, AppColors.greenAccent),
    _ExpenseSlice('Software', 10625, AppColors.indigoPale),
  ];

  @override
  Widget build(BuildContext context) {
    final total = slices.fold<double>(0, (sum, s) => sum + s.amount);

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
            'SPENDING BREAKDOWN',
            style: TextStyle(
              color: AppColors.textFaint,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: 220,
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(220, 220),
                    painter: _DonutPainter(slices: slices, total: total),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${(total / 1000).toStringAsFixed(1)}k',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Total June',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
          for (final s in slices) ...[
            _LegendRow(slice: s),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<_ExpenseSlice> slices;
  final double total;
  const _DonutPainter({required this.slices, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 34.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (size.shortestSide - strokeWidth) / 2;
    final arcRect = Rect.fromCircle(center: center, radius: radius);

    var startAngle = -3.14159265 / 2; // start at top
    for (final s in slices) {
      final sweep = (s.amount / total) * 2 * 3.14159265;
      final paint = Paint()
        ..color = s.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(arcRect, startAngle, sweep, false, paint);
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) => false;
}

class _LegendRow extends StatelessWidget {
  final _ExpenseSlice slice;
  const _LegendRow({required this.slice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: slice.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Text(
          slice.label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          '\$${_formatAmount(slice.amount)}',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static String _formatAmount(double value) {
    final s = value.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}

// ---------------------------------------------------------------------------
// Budget status
// ---------------------------------------------------------------------------
class _BudgetStatusCard extends StatelessWidget {
  const _BudgetStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.indigo,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Budget Status',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You've used 68% of the quarterly allocation. Momentum is high for Q3 initiatives.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '\$125,000',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'REMAINING BALANCE',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Material(
                  color: const Color(0xFF181C36),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: Text(
                        'Adjust\nBudget',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ),
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
// Mini stats row
// ---------------------------------------------------------------------------
class _MiniStatsRow extends StatelessWidget {
  const _MiniStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF0E7A50),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.white,
                  size: 26,
                ),
                const SizedBox(height: 28),
                const Text(
                  '12',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pending Approvals',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.bolt, color: AppColors.indigoLight, size: 26),
                const SizedBox(height: 28),
                const Text(
                  'Avg. 4h',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Reimbursement Speed',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Filter row
// ---------------------------------------------------------------------------
class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.filter_list, color: AppColors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Material(
          color: AppColors.indigoPale,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.indigo, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'New Report',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
            flex: 4,
            child: Text(
              'EMPLOYEE',
              style: TextStyle(
                color: AppColors.textFaint,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'CATEGORY',
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
// Reports list
// ---------------------------------------------------------------------------
class _ExpenseReport {
  final String name;
  final IconData categoryIcon;
  final String category;
  final String date;
  final bool highlighted;
  final String? initials;

  const _ExpenseReport({
    required this.name,
    required this.categoryIcon,
    required this.category,
    required this.date,
    this.highlighted = false,
    this.initials,
  });
}

class _ReportsList extends StatelessWidget {
  const _ReportsList();

  static const reports = [
    _ExpenseReport(
      name: 'Jordan Davis',
      categoryIcon: Icons.flight_takeoff,
      category: 'Travel',
      date: 'Jun 12, 2024',
    ),
    _ExpenseReport(
      name: 'Sarah Miller',
      categoryIcon: Icons.desktop_windows_outlined,
      category: 'Equipment',
      date: 'Jun 14, 2024',
    ),
    _ExpenseReport(
      name: 'Robert King',
      categoryIcon: Icons.mail_outline,
      category: 'Software',
      date: 'Jun 15, 2024',
      highlighted: true,
      initials: 'RK',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cardDarker,
      child: Column(
        children: [
          for (int i = 0; i < reports.length; i++) ...[
            if (i > 0)
              Divider(height: 1, color: Colors.white.withOpacity(0.06)),
            _ReportRow(report: reports[i]),
          ],
        ],
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  final _ExpenseReport report;
  const _ReportRow({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: report.highlighted
            ? AppColors.indigo.withOpacity(0.12)
            : Colors.transparent,
        border: report.highlighted
            ? const Border(
                left: BorderSide(color: AppColors.indigoLight, width: 3),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: report.initials != null
                      ? Text(
                          report.initials!,
                          style: const TextStyle(
                            color: AppColors.slate,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    report.name,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Icon(report.categoryIcon, color: AppColors.textMuted, size: 15),
                const SizedBox(width: 6),
                Text(
                  report.category,
                  style: const TextStyle(color: AppColors.white, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              report.date,
              textAlign: TextAlign.right,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer pager
// ---------------------------------------------------------------------------
class _FooterPager extends StatelessWidget {
  const _FooterPager();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cardDarker,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          const Text(
            'Showing 3 of 42 records',
            style: TextStyle(color: AppColors.textMuted, fontSize: 12.5),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_left,
            color: Colors.white.withOpacity(0.4),
            size: 20,
          ),
          const SizedBox(width: 16),
          const Icon(Icons.chevron_right, color: AppColors.white, size: 20),
        ],
      ),
    );
  }
}
