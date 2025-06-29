import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/gradient_container.dart';
import '../../../../core/constants/app_constants.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  final List<String> enfermedades = [
    'Zika',
    'Sarampión',
    'Influenza',
    'Bronquitis',
    'Gripe AH1N1',
  ];
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return false;
      setState(() {
        currentIndex = (currentIndex + 1) % enfermedades.length;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      colors: const [Color(0xFF2196F3), Color(0xFF21CBF3), Color(0xFF03DAC6)],
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largeSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.health_and_safety,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              'Monitoreo Epidemiológico',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Vigilancia y control de brotes en tiempo real',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.coronavirus,
                            color: const Color.fromARGB(179, 207, 24, 24),
                            size: 15,
                          ),
                          const SizedBox(width: 4),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 700),
                            transitionBuilder: (child, animation) {
                              final inAnimation = Tween<Offset>(
                                begin: const Offset(0.0, 0.5),
                                end: Offset.zero,
                              ).animate(animation);
                              final outAnimation = Tween<Offset>(
                                begin: Offset.zero,
                                end: const Offset(0.0, -0.5),
                              ).animate(animation);
                              if (child.key ==
                                  ValueKey(enfermedades[currentIndex])) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: inAnimation,
                                    child: child,
                                  ),
                                );
                              } else {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: outAnimation,
                                    child: child,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              enfermedades[currentIndex],
                              key: ValueKey(enfermedades[currentIndex]),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.monitor_heart_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // _getTodayDate eliminado, ya no se usa
}
