import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _DiseaseDropdown extends StatefulWidget {
  @override
  State<_DiseaseDropdown> createState() => _DiseaseDropdownState();
}

class _DiseaseDropdownState extends State<_DiseaseDropdown> {
  final List<String> diseases = [
    'Zika',
    'Sarampión',
    'Influenza',
    'Bronquitis',
    'Gripe Ah1n1',
  ];
  String selected = 'Zika';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF2196F3)),
          dropdownColor: Colors.white,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF2196F3),
            fontWeight: FontWeight.w500,
          ),
          items:
              diseases
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selected = value;
              });
            }
          },
        ),
      ),
    );
  }
}
