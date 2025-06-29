import 'package:flutter/material.dart';

import '../widgets/dashboard_header.dart';
import '../widgets/stats_grid.dart';
import '../widgets/chart_section.dart';
import '../../../../core/constants/app_constants.dart';
import 'jump_target_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              const SizedBox(height: AppConstants.largeSpacing),
              const StatsGrid(),
              const SizedBox(height: AppConstants.largeSpacing),
              const ChartSection(),
              const SizedBox(height: AppConstants.largeSpacing),
              // ...existing code...
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 5), // Más abajo
        child: SizedBox(
          width: 48,
          height: 48,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const JumpTargetScreen()),
              );
            },
            backgroundColor: Colors.blueAccent,
            child: const Icon(Icons.arrow_downward, size: 20),
            shape: const CircleBorder(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
