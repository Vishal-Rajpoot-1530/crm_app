import 'package:crm_app/screen/dashboard_grid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CRMApp());
}

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A0F1E),
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}