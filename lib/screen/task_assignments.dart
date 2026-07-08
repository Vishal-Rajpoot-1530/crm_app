import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// TASK MANAGEMENT SCREEN
/// Drop `TaskManagementScreen` into any MaterialApp. No external packages
/// required — everything uses core Flutter + Material Icons. Avatars use
/// colored initial-circles instead of network images so the file runs with
/// zero setup; swap in NetworkImage/AssetImage where noted.
/// -----------------------------------------------------------------------

void main() => runApp(const CrmApp());

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
      home: const TaskManagementScreen(),
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
  static const navBackground = Color(0xFFE4E6FB);
}

/// ---------------------------- MODELS --------------------------------------
enum Priority { high, med, low }

extension PriorityX on Priority {
  String get label {
    switch (this) {
      case Priority.high:
        return 'High';
      case Priority.med:
        return 'Med';
      case Priority.low:
        return 'Low';
    }
  }

  Color get color {
    switch (this) {
      case Priority.high:
        return AppColors.danger;
      case Priority.med:
        return AppColors.primary;
      case Priority.low:
        return AppColors.success;
    }
  }

  IconData get icon {
    switch (this) {
      case Priority.high:
        return Icons.error_outline_rounded;
      case Priority.med:
        return Icons.bolt_rounded;
      case Priority.low:
        return Icons.low_priority_rounded;
    }
  }
}

class Assignee {
  final String initials;
  final Color color;
  const Assignee(this.initials, this.color);
}

class Task {
  final Priority priority;
  final String title;
  final String description;
  final String date;
  final List<Assignee> assignees;
  final int? progress; // 0-100, null if not in progress
  final bool completed;
  final String? completedSubtitle;

  const Task({
    required this.priority,
    required this.title,
    required this.description,
    required this.date,
    required this.assignees,
    this.progress,
    this.completed = false,
    this.completedSubtitle,
  });
}

/// ---------------------------- SCREEN --------------------------------------
class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final List<Task> _todo = const [
    Task(
      priority: Priority.high,
      title: 'Quarterly Performance Audit',
      description:
          'Complete the comprehensive audit of all regional sales teams for Q3 performance...',
      date: 'Oct 24, 2023',
      assignees: [Assignee('JS', Color(0xFF4A6FE0))],
    ),
    Task(
      priority: Priority.low,
      title: 'Update Client Directory',
      description:
          'Sync the offline database with the current CRM leads list for the Mumbai office.',
      date: 'Nov 02, 2023',
      assignees: [Assignee('EL', Color(0xFFE07A9E))],
    ),
  ];

  final List<Task> _inProgress = const [
    Task(
      priority: Priority.med,
      title: 'CRM Integration Test',
      description: 'Running final API tests for the new sales-force automation module.',
      date: 'Today',
      assignees: [
        Assignee('RC', Color(0xFFE07A9E)),
        Assignee('MW', Color(0xFF4A6FE0)),
      ],
      progress: 65,
    ),
  ];

  final List<Task> _completed = const [
    Task(
      priority: Priority.med,
      title: 'Monthly Budget Approval',
      description: 'Approved by Finance Dept on Oct 12.',
      date: '',
      assignees: [Assignee('WT', Color(0xFF4A6FE0))],
      completed: true,
    ),
  ];

  int _navIndex = 2; // Tasks tab active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _TopBar(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                    children: [
                      const Text(
                        'Task Management',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Organize, track, and assign operational objectives.',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          _FilterButton(onTap: () {}),
                          const SizedBox(width: 12),
                          _NewTaskButton(onTap: () {}),
                        ],
                      ),
                      const SizedBox(height: 26),
                      _SectionHeader(
                        title: 'To Do',
                        count: _todo.length,
                        accentColor: AppColors.primary,
                      ),
                      const SizedBox(height: 14),
                      ..._todo.map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _TaskCard(task: t),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _SectionHeader(
                        title: 'In Progress',
                        count: _inProgress.length,
                        accentColor: AppColors.primary,
                      ),
                      const SizedBox(height: 14),
                      ..._inProgress.map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _TaskCard(task: t, highlighted: true),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _SectionHeader(
                        title: 'Completed',
                        count: _completed.length,
                        accentColor: AppColors.success,
                      ),
                      const SizedBox(height: 14),
                      ..._completed.map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _TaskCard(task: t),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 88,
              child: _Fab(onTap: () {}),
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

/// ---------------------------- TOP BAR --------------------------------------
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu_rounded, color: Colors.black87),
          Row(
            children: const [
              Icon(Icons.search_rounded, color: Colors.black87),
              SizedBox(width: 16),
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, size: 16, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------- FILTER / NEW TASK BUTTONS ---------------------
class _FilterButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.tune_rounded, size: 17),
      label: const Text('Filter', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}

class _NewTaskButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NewTaskButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.add_rounded, size: 18),
        label: const Text('New Task', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

/// ---------------------------- SECTION HEADER ---------------------------------
class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color accentColor;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        const Icon(Icons.more_horiz_rounded, color: AppColors.textSecondary),
      ],
    );
  }
}

/// ---------------------------- TASK CARD ---------------------------------
class _TaskCard extends StatelessWidget {
  final Task task;
  final bool highlighted;

  const _TaskCard({required this.task, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    if (task.completed) return _CompletedCard(task: task);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted ? AppColors.primary : AppColors.border,
          width: highlighted ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PriorityBadge(priority: task.priority),
              const Icon(Icons.drag_indicator_rounded, color: AppColors.textSecondary, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            task.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            task.description,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
          ),
          if (task.progress != null) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${task.progress}%',
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 12.5, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: task.progress! / 100,
                minHeight: 6,
                backgroundColor: AppColors.surfaceAlt,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text(
                    task.date,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
                  ),
                ],
              ),
              _AvatarStack(assignees: task.assignees),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompletedCard extends StatelessWidget {
  final Task task;
  const _CompletedCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle_outline_rounded, size: 13, color: AppColors.success),
                    SizedBox(width: 5),
                    Text(
                      'Done',
                      style: TextStyle(color: AppColors.success, fontSize: 11.5, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            task.title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            task.description,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.sync_rounded, size: 14, color: AppColors.success),
                  SizedBox(width: 6),
                  Text(
                    'Completed',
                    style: TextStyle(color: AppColors.success, fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              _AvatarStack(assignees: task.assignees),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final Priority priority;
  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: priority.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(priority.icon, size: 13, color: priority.color),
          const SizedBox(width: 5),
          Text(
            priority.label,
            style: TextStyle(color: priority.color, fontSize: 11.5, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

/// Stack of small circular avatars. Replace the initials Container with
/// CircleAvatar(backgroundImage: NetworkImage(url)) to use real photos.
class _AvatarStack extends StatelessWidget {
  final List<Assignee> assignees;
  const _AvatarStack({required this.assignees});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Stack(
        children: List.generate(assignees.length, (i) {
          final a = assignees[i];
          return Positioned(
            right: i * 18.0,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: a.color,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                a.initials,
                style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700),
              ),
            ),
          );
        }).reversed.toList(),
      ),
    );
  }
}

/// ---------------------------- FAB ------------------------------------
class _Fab extends StatelessWidget {
  final VoidCallback onTap;
  const _Fab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 54,
          height: 54,
          child: Icon(Icons.add_rounded, color: Colors.white, size: 26),
        ),
      ),
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
    (icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today_rounded, label: 'Attendance'),
    (icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navBackground,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final item = _items[i];
            final selected = i == selectedIndex;
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      selected ? item.activeIcon : item.icon,
                      color: selected ? Colors.white : Colors.black54,
                      size: 20,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black54,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}