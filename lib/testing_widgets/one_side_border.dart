import 'package:flutter/material.dart';

class OneSideBorder extends StatelessWidget {
  const OneSideBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF14182A), // dark card background
          borderRadius: BorderRadius.circular(16),
          border: const Border(
            left: BorderSide(
              color: Color(0xFF6C63F5),
              width: 5,
            ), // <- the accent
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '+12%',
              style: TextStyle(color: Colors.greenAccent, fontSize: 12),
            ),
            SizedBox(height: 8),
            Text(
              'Active Leads',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              '1,284',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
