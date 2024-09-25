import 'package:flutter/material.dart';

class LandingCard extends StatelessWidget {
  final Widget image;
  final String name;

  // Define a placeholder color for backgroundPrimary
  final Color backgroundPrimary = Colors.black; // Change this to your desired color

  const LandingCard({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                image,
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        backgroundPrimary.withOpacity(0.50),
                        backgroundPrimary.withOpacity(0.75),
                        backgroundPrimary.withOpacity(1.00),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundPrimary.withOpacity(0.80),
                  backgroundPrimary.withOpacity(0.60),
                  backgroundPrimary.withOpacity(0.40),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
