import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// Vibrant CRM - Task Details Screen
///
/// Drop this file into your `lib/screens/` folder and push it like:
///   Navigator.push(context, MaterialPageRoute(builder: (_) => const TaskDetailsScreen()));
///
/// No external packages required - pure Flutter/Material.
/// ---------------------------------------------------------------------------

class AppColors {
  static const bg = Color(0xFF0A0E1A);
  static const card = Color(0xFFFFFFFF);
  static const purple = Color(0xFF5B4FE8);
  static const purpleSoft = Color(0xFFEDEBFF);
  static const green = Color(0xFF12A150);
  static const greenSoft = Color(0x1F12A150);
  static const red = Color(0xFFE0687A);
  static const textDark = Color(0xFF15182B);
  static const textGrey = Color(0xFF8A90A0);
  static const textMuted = Color(0xFF6B7280);
  static const divider = Color(0xFFEDEEF2);
  static const chipBg = Color(0x14FFFFFF);
  static const navyPanel = Color(0xFF11162A);
}

// ---------------------------------------------------------------------------
// DATA MODELS
// ---------------------------------------------------------------------------
class SubTask {
  final String title;
  final bool completed;
  const SubTask(this.title, this.completed);
}

class CommentItem {
  final String name;
  final String time;
  final String message;
  final int likes;
  final Color avatarColor;
  const CommentItem({
    required this.name,
    required this.time,
    required this.message,
    required this.likes,
    required this.avatarColor,
  });
}

class AttachmentItem {
  final String name;
  final String size;
  final IconData icon;
  final Color iconColor;
  const AttachmentItem(this.name, this.size, this.icon, this.iconColor);
}

// ---------------------------------------------------------------------------
// SCREEN
// ---------------------------------------------------------------------------
class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  int _navIndex = 2; // Tasks tab active
  String _status = 'In Progress';
  final _commentController = TextEditingController();

  final List<SubTask> _subTasks = const [
    SubTask('Export historical sales data from 2022-2023', true),
    SubTask('Host alignment meeting with APAC Regional Lead', true),
    SubTask('Draft preliminary growth strategy slides', false),
    SubTask('Review tax implications with CFO office', false),
  ];

  final List<CommentItem> _comments = const [
    CommentItem(
      name: 'Marcus Chen',
      time: '2 hours ago',
      message:
          'The APAC lead mentioned some delays in Singapore reporting. Should we account for a 5% margin of error in our first draft?',
      likes: 3,
      avatarColor: Color(0xFF5C6B8A),
    ),
    CommentItem(
      name: 'Sarah Jenkins',
      time: '45 mins ago',
      message:
          "Agreed, Marcus. I'll add a 'Variable Scenario' section to the presentation to handle those APAC fluctuations.",
      likes: 0,
      avatarColor: Color(0xFFB08968),
    ),
  ];

  final List<AttachmentItem> _attachments = const [
    AttachmentItem('Q3_Final_Report.pdf', '4.2 MB', Icons.picture_as_pdf,
        Color(0xFFE0687A)),
    AttachmentItem('Revenue_Data_Sheet.xlsx', '1.1 MB', Icons.grid_on,
        Color(0xFF12A150)),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completed = _subTasks.where((s) => s.completed).length;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            _buildBreadcrumb(),
            const SizedBox(height: 10),
            _buildEditButton(),
            const SizedBox(height: 16),
            _buildTitleCard(),
            const SizedBox(height: 16),
            _buildSubtasksCard(completed),
            const SizedBox(height: 16),
            _buildCollaborationCard(),
            const SizedBox(height: 16),
            _buildTaskStatusCard(),
            const SizedBox(height: 16),
            _buildProjectInfoCard(),
            const SizedBox(height: 16),
            _buildAttachmentsCard(),
          ],
        ),
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
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Task Details',
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.ios_share, color: Colors.white, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded,
              color: Colors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // BREADCRUMB + EDIT BUTTON
  // ---------------------------------------------------------------------
  Widget _buildBreadcrumb() {
    Widget crumb(String t, {bool active = false}) => Text(
          t,
          style: TextStyle(
            color: active ? Colors.white : AppColors.textMuted,
            fontSize: 12.5,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          ),
        );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        crumb('Dashboard'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right, size: 14, color: AppColors.textMuted),
        ),
        crumb('Tasks'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right, size: 14, color: AppColors.textMuted),
        ),
        crumb('Q4 Revenue Analysis', active: true),
      ],
    );
  }

  Widget _buildEditButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined, size: 15, color: Colors.white),
        label: const Text('Edit Task',
            style: TextStyle(color: Colors.white, fontSize: 12.5)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          side: const BorderSide(color: Color(0x33FFFFFF)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TITLE CARD
  // ---------------------------------------------------------------------
  Widget _buildTitleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0x0FFFFFFF),
        borderRadius: BorderRadius.circular(18),
        border: const Border(
          top: BorderSide(color: AppColors.green, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.greenSoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('High Priority',
                          style: TextStyle(
                              color: AppColors.green,
                              fontSize: 11,
                              fontWeight: FontWeight.w700)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.calendar_today,
                            size: 12.5, color: AppColors.textMuted),
                        SizedBox(width: 5),
                        Text('Due Oct 24, 2023',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              _buildMiniAvatarStack(),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Q4 Revenue Growth Analysis & Implementation',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.3),
          ),
          const SizedBox(height: 18),
          const Text('Description',
              style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Divider(color: Color(0x14FFFFFF), height: 1),
          const SizedBox(height: 12),
          const Text(
            'This task involves a comprehensive deep-dive into our current revenue streams and identifying underperforming sectors for the upcoming Q4 period. We need to align with the regional managers to ensure our projection models reflect real-time market shifts. The final output should be a 15-page executive summary including interactive data visualizations and a clear roadmap for implementation.',
            style: TextStyle(
                color: AppColors.textMuted, fontSize: 13.5, height: 1.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'Note: Please cross-reference data with the Salesforce exported reports from last Monday.',
            style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
                height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniAvatarStack() {
    final colors = [
      const Color(0xFFB08968),
      const Color(0xFF5C6B8A),
      const Color(0xFF7A8B6F),
    ];
    return SizedBox(
      width: 62,
      height: 30,
      child: Stack(
        children: [
          ...List.generate(colors.length, (i) {
            return Positioned(
              left: i * 16.0,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.bg,
                child: CircleAvatar(radius: 13, backgroundColor: colors[i]),
              ),
            );
          }),
          Positioned(
            left: colors.length * 16.0,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.bg,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: const Color(0xFF2A2F42),
                child: const Text('+3',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // SUB-TASKS CARD
  // ---------------------------------------------------------------------
  Widget _buildSubtasksCard(int completed) {
    final total = _subTasks.length;
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.checklist_rtl, size: 18, color: AppColors.purple),
              const SizedBox(width: 8),
              const Text('Sub-tasks',
                  style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('$completed of $total completed',
                  style: const TextStyle(
                      color: AppColors.textGrey, fontSize: 12.5)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: completed / total,
              minHeight: 6,
              backgroundColor: const Color(0xFFEDEEF2),
              valueColor: const AlwaysStoppedAnimation(AppColors.purple),
            ),
          ),
          const SizedBox(height: 14),
          for (final t in _subTasks) ...[
            _subtaskRow(t),
            const SizedBox(height: 8),
          ],
          DottedAddButton(label: 'Add Sub-task', onTap: () {}),
        ],
      ),
    );
  }

  Widget _subtaskRow(SubTask t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: t.completed ? AppColors.purple : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: t.completed
                      ? AppColors.purple
                      : const Color(0xFFC7CAD4)),
            ),
            child: t.completed
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.title,
              style: TextStyle(
                color: t.completed
                    ? AppColors.textGrey
                    : AppColors.textDark,
                fontSize: 13,
                decoration:
                    t.completed ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TEAM COLLABORATION CARD
  // ---------------------------------------------------------------------
  Widget _buildCollaborationCard() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.forum_outlined, size: 18, color: AppColors.purple),
              SizedBox(width: 8),
              Text('Team Collaboration',
                  style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 14),
          for (final c in _comments) ...[
            _commentRow(c),
            const SizedBox(height: 14),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.purple,
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    hintStyle:
                        const TextStyle(color: AppColors.textGrey, fontSize: 13),
                    filled: true,
                    fillColor: const Color(0xFFF7F7FA),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Post Comment',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentRow(CommentItem c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 16, backgroundColor: c.avatarColor),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(c.name,
                      style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Text(c.time,
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 4),
              Text(c.message,
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 12.5, height: 1.4)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.reply, size: 14, color: AppColors.textGrey),
                  const SizedBox(width: 4),
                  const Text('Reply',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 11.5)),
                  const SizedBox(width: 14),
                  const Icon(Icons.thumb_up_alt_outlined,
                      size: 13, color: AppColors.textGrey),
                  const SizedBox(width: 4),
                  Text('${c.likes}',
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 11.5)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // TASK STATUS CARD
  // ---------------------------------------------------------------------
  Widget _buildTaskStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.navyPanel,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TASK STATUS',
              style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8)),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: const Color(0x14FFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0x1FFFFFFF)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _status,
                isExpanded: true,
                dropdownColor: AppColors.navyPanel,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                items: const [
                  DropdownMenuItem(value: 'To Do', child: Text('To Do')),
                  DropdownMenuItem(
                      value: 'In Progress', child: Text('In Progress')),
                  DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                ],
                onChanged: (v) => setState(() => _status = v ?? _status),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _statusStat('Time Tracked', '12h 45m')),
              Expanded(child: _statusStat('Estimate', '20h 00m')),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
              label: const Text('Start Timer',
                  style: TextStyle(color: Colors.white, fontSize: 13.5)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                side: const BorderSide(color: Color(0x33FFFFFF)),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // PROJECT INFO CARD
  // ---------------------------------------------------------------------
  Widget _buildProjectInfoCard() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PROJECT INFO',
              style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6)),
          const SizedBox(height: 14),
          _infoRow(Icons.folder_outlined, 'Project', 'Annual Strategy 2024'),
          const SizedBox(height: 12),
          _infoRow(Icons.label_outline, 'Category', 'Market Analysis'),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.purpleSoft,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, size: 17, color: AppColors.purple),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: AppColors.textGrey, fontSize: 11.5)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // ATTACHMENTS CARD
  // ---------------------------------------------------------------------
  Widget _buildAttachmentsCard() {
    return _whiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('ATTACHMENTS',
                  style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6)),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: const Text('Upload',
                    style: TextStyle(
                        color: AppColors.purple,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final a in _attachments) ...[
            _attachmentRow(a),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _attachmentRow(AttachmentItem a) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(a.icon, size: 20, color: a.iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(a.name,
                style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
          Text(a.size,
              style: const TextStyle(color: AppColors.textGrey, fontSize: 11.5)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // SHARED
  // ---------------------------------------------------------------------
  Widget _whiteCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
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
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, color: Colors.white, size: 20),
                          const SizedBox(height: 2),
                          Text(label,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: AppColors.textMuted, size: 20),
                        const SizedBox(height: 4),
                        Text(label,
                            style: const TextStyle(
                                color: AppColors.textMuted, fontSize: 10)),
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
// SHARED WIDGET: dashed "add" button used for sub-tasks
// ---------------------------------------------------------------------------
class DottedAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const DottedAddButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, size: 16, color: AppColors.textGrey),
              SizedBox(width: 6),
              Text('Add Sub-task',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 12.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC7CAD4)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final rrect = RRect.fromRectAndRadius(
        Offset.zero & size, const Radius.circular(10));
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
            metric.extractPath(distance, next.clamp(0, metric.length)), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}