import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// Vibrant CRM - Attendance History Screen
///
/// Drop this file into your `lib/screens/` folder and push it like:
///   Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceHistoryScreen()));
///
/// No external packages required - pure Flutter/Material.
/// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// COLORS
// ---------------------------------------------------------------------------
class AppColors {
  static const bg = Color(0xFF0A0E1A);
  static const cardGlass = Color(0x1FFFFFFF); // frosted translucent card
  static const cardGlassBorder = Color(0x14FFFFFF);
  static const purple = Color(0xFF5B4FE8);
  static const purpleDark = Color(0xFF4338CA);
  static const green = Color(0xFF1F9D63);
  static const peach = Color(0xFFF0A08A);
  static const leavePurple = Color(0xFF8B85F0);
  static const holidayGrey = Color(0xFF6B7280);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFFAEB4C2);
  static const textMuted = Color(0xFF6B7280);
}

// ---------------------------------------------------------------------------
// DATA MODELS
// ---------------------------------------------------------------------------
enum DayStatus { present, absent, leave, holiday, weekend, none }

class CalendarDay {
  final int day;
  final DayStatus status;
  const CalendarDay(this.day, this.status);
}

enum LogStatus { present, absent, holiday, leave }

class DailyLog {
  final String dateDay; // "10"
  final String dateMonth; // "OCT"
  final String weekday; // "Tuesday"
  final LogStatus status;
  final String? timeIn;
  final String? timeOut;
  final String? duration;
  final String? note;
  const DailyLog({
    required this.dateDay,
    required this.dateMonth,
    required this.weekday,
    required this.status,
    this.timeIn,
    this.timeOut,
    this.duration,
    this.note,
  });
}

// ---------------------------------------------------------------------------
// SCREEN
// ---------------------------------------------------------------------------
class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  int _selectedDay = 10;
  int _navIndex = 3; // Attendance tab active
  bool _showRecent = true;

  // Sample month data (October 2023). Replace with real data from your API.
  final List<CalendarDay> _calendarDays = const [
    CalendarDay(1, DayStatus.weekend),
    CalendarDay(2, DayStatus.weekend),
    CalendarDay(3, DayStatus.present),
    CalendarDay(4, DayStatus.present),
    CalendarDay(5, DayStatus.absent),
    CalendarDay(6, DayStatus.present),
    CalendarDay(7, DayStatus.holiday),
    CalendarDay(8, DayStatus.weekend),
    CalendarDay(9, DayStatus.weekend),
    CalendarDay(10, DayStatus.present),
    CalendarDay(11, DayStatus.present),
    CalendarDay(12, DayStatus.present),
    CalendarDay(13, DayStatus.present),
    CalendarDay(14, DayStatus.weekend),
    CalendarDay(15, DayStatus.weekend),
    CalendarDay(16, DayStatus.present),
    CalendarDay(17, DayStatus.present),
    CalendarDay(18, DayStatus.present),
    CalendarDay(19, DayStatus.present),
    CalendarDay(20, DayStatus.holiday),
    CalendarDay(21, DayStatus.weekend),
    CalendarDay(22, DayStatus.weekend),
    CalendarDay(23, DayStatus.present),
    CalendarDay(24, DayStatus.present),
    CalendarDay(25, DayStatus.absent),
    CalendarDay(26, DayStatus.present),
    CalendarDay(27, DayStatus.present),
    CalendarDay(28, DayStatus.weekend),
    CalendarDay(29, DayStatus.weekend),
    CalendarDay(30, DayStatus.leave),
    CalendarDay(31, DayStatus.present),
  ];

  final List<DailyLog> _logs = const [
    DailyLog(
      dateDay: '10',
      dateMonth: 'OCT',
      weekday: 'Tuesday',
      status: LogStatus.present,
      timeIn: '08:54 AM',
      timeOut: '06:12 PM',
      duration: '9h 18m',
    ),
    DailyLog(
      dateDay: '05',
      dateMonth: 'OCT',
      weekday: 'Thursday',
      status: LogStatus.absent,
      note: 'No clock-in data recorded for this day.',
    ),
    DailyLog(
      dateDay: '07',
      dateMonth: 'OCT',
      weekday: 'Saturday',
      status: LogStatus.holiday,
      note: 'National Day observance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildActionButtons(),
            const SizedBox(height: 20),
            _buildCalendarCard(),
            const SizedBox(height: 16),
            _buildMonthSummaryCard(),
            const SizedBox(height: 16),
            _buildStatusDistributionCard(),
            const SizedBox(height: 24),
            _buildDailyLogHeader(),
            const SizedBox(height: 16),
            for (final log in _logs) ...[
              _buildLogCard(log),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomNav(),
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
        const Padding(
          padding: EdgeInsets.only(right: 16, left: 4),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF3A3F52),
            child: Icon(Icons.person, color: Colors.white70, size: 18),
          ),
        ),
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
          'EMPLOYEE PORTAL',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Attendance History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.file_download_outlined,
              size: 18,
              color: Colors.white,
            ),
            label: const Text(
              'Export Report',
              style: TextStyle(color: Colors.white, fontSize: 13.5),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 13),
              side: const BorderSide(color: Color(0x33FFFFFF)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month_outlined,
              size: 18,
              color: Colors.white,
            ),
            label: const Text(
              'Request Leave',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // CALENDAR CARD
  // ---------------------------------------------------------------------
  Widget _buildCalendarCard() {
    const weekLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    // October 2023 starts on a Sunday -> leading blanks for Mon-Sat = 6
    const leadingBlanks = 6;

    return _GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.calendar_today, size: 16, color: Colors.white70),
                  SizedBox(width: 8),
                  Text(
                    'October 2023',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _navArrow(Icons.chevron_left),
                  const SizedBox(width: 8),
                  _navArrow(Icons.chevron_right),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: weekLabels
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: leadingBlanks + _calendarDays.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 2,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              if (index < leadingBlanks) return const SizedBox.shrink();
              final day = _calendarDays[index - leadingBlanks];
              return _buildDayCell(day);
            },
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0x1FFFFFFF), height: 1),
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: const [
              _LegendDot(color: AppColors.green, label: 'Present'),
              _LegendDot(color: AppColors.peach, label: 'Absent'),
              _LegendDot(color: AppColors.leavePurple, label: 'Leave'),
              _LegendDot(
                color: AppColors.holidayGrey,
                label: 'Holiday/Weekend',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navArrow(IconData icon) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: Colors.white70),
    );
  }

  Widget _buildDayCell(CalendarDay day) {
    final isSelected = day.day == _selectedDay;
    Color? dotColor;
    switch (day.status) {
      case DayStatus.present:
        dotColor = AppColors.green;
        break;
      case DayStatus.absent:
        dotColor = AppColors.peach;
        break;
      case DayStatus.leave:
        dotColor = AppColors.leavePurple;
        break;
      case DayStatus.holiday:
      case DayStatus.weekend:
        dotColor = AppColors.holidayGrey.withOpacity(0.5);
        break;
      case DayStatus.none:
        dotColor = null;
    }

    final isDimmed =
        day.status == DayStatus.weekend || day.status == DayStatus.holiday;

    return GestureDetector(
      onTap: () => setState(() => _selectedDay = day.day),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.purple : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : isDimmed
                    ? Colors.white24
                    : Colors.white70,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 3),
          if (dotColor != null)
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // THIS MONTH SUMMARY
  // ---------------------------------------------------------------------
  Widget _buildMonthSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.purple, AppColors.purpleDark],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THIS MONTH',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '162',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' Total Hours',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _summaryStat('Present Days', '18')),
              Expanded(child: _summaryStat('Avg. Daily', '9.0h')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12.5),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // STATUS DISTRIBUTION
  // ---------------------------------------------------------------------
  Widget _buildStatusDistributionCard() {
    // Values driving the stacked bar (out of 21 working days, for example)
    const regular = 18;
    const halfLeave = 2;
    const sickLeave = 1;
    const total = regular + halfLeave + sickLeave;

    return _GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Distribution',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: regular,
                    child: Container(color: AppColors.green),
                  ),
                  Expanded(
                    flex: halfLeave,
                    child: Container(color: AppColors.leavePurple),
                  ),
                  Expanded(
                    flex: sickLeave,
                    child: Container(color: AppColors.peach),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _distributionRow('Regular Days', regular),
          const SizedBox(height: 8),
          _distributionRow('Half Leave', halfLeave),
          const SizedBox(height: 8),
          _distributionRow('Sick Leave', sickLeave),
        ],
      ),
    );
  }

  Widget _distributionRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // DAILY LOG
  // ---------------------------------------------------------------------
  Widget _buildDailyLogHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Daily Log Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: const Color(0x1FFFFFFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              _segmentButton('Recent', true),
              _segmentButton('Exceptions Only', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _segmentButton(String label, bool value) {
    final isActive = _showRecent == value;
    return GestureDetector(
      onTap: () => setState(() => _showRecent = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2A2F42) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textMuted,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLogCard(DailyLog log) {
    Color barColor;
    Widget badge;
    switch (log.status) {
      case LogStatus.present:
        barColor = AppColors.green;
        badge = _StatusBadge(text: 'PRESENT', color: AppColors.green);
        break;
      case LogStatus.absent:
        barColor = AppColors.peach;
        badge = _StatusBadge(text: 'ABSENT', color: AppColors.peach);
        break;
      case LogStatus.holiday:
        barColor = Colors.white24;
        badge = const _StatusBadge(
          text: 'PUBLIC HOLIDAY',
          color: AppColors.holidayGrey,
        );
        break;
      case LogStatus.leave:
        barColor = AppColors.leavePurple;
        badge = const _StatusBadge(text: 'LEAVE', color: AppColors.leavePurple);
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: 3, decoration: BoxDecoration(color: barColor)),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x0FFFFFFF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0x14FFFFFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log.dateMonth,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            log.dateDay,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          log.weekday,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      badge,
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (log.status == LogStatus.present) ...[
                    _logRow('In', log.timeIn ?? '-'),
                    const SizedBox(height: 6),
                    _logRow('Out', log.timeOut ?? '-'),
                    const SizedBox(height: 6),
                    _logRow('Duration', log.duration ?? '-', bold: true),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: Colors.white70,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                            size: 18,
                            color: Colors.white70,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ] else if (log.status == LogStatus.absent) ...[
                    Text(
                      log.note ?? '',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.peach.withOpacity(0.18),
                          foregroundColor: AppColors.peach,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Regularize',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      log.note ?? '',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          size: 18,
                          color: Colors.white38,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // BOTTOM NAV
  // ---------------------------------------------------------------------
  Widget _buildBottomNav() {
    final items = [
      (Icons.dashboard_outlined, 'Dashboard'),
      (Icons.groups_outlined, 'Leads'),
      (Icons.check_box_outlined, 'Tasks'),
      (Icons.calendar_today_outlined, 'Attendance'),
      (Icons.person_outline, 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: Color(0x1FFFFFFF))),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final isActive = i == _navIndex;
            final (icon, label) = items[i];
            return GestureDetector(
              onTap: () => setState(() => _navIndex = i),
              child: isActive
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, color: Colors.white, size: 20),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: AppColors.textMuted, size: 20),
                        const SizedBox(height: 4),
                        Text(
                          label,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                          ),
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

// ---------------------------------------------------------------------------
// SHARED WIDGETS
// ---------------------------------------------------------------------------
class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const _GlassCard({required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.cardGlass,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardGlassBorder),
      ),
      child: child,
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 10.5),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  const _StatusBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
