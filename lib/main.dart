// import 'package:crm_app/screen/attendance_history.dart';
// import 'package:crm_app/screen/company_expenses.dart';
// import 'package:crm_app/screen/dashboard.dart';
// import 'package:crm_app/screen/dashboard_guid.dart';
// import 'package:crm_app/screen/login.dart';
import 'package:crm_app/screen/domain_details.dart';
import 'package:crm_app/screen/lead_won_details.dart';
import 'package:crm_app/testing_widgets/one_side_border.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const VibrantCRMApp());
}

class VibrantCRMApp extends StatelessWidget {
  const VibrantCRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibrant CRM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter', // falls back to system font if not bundled
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        brightness: Brightness.dark,
      ),
      // Swap `home` to preview any screen directly, e.g. DashboardScreen(),
      // PaymentHistoryScreen(), ExpensesScreen(), SubscriptionScreen(),
      // or LeadDetailScreen().
      home: const OneSideBorder(),
    );
  }
}
