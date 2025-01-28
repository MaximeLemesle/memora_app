import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.all(24),
      height: 140,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          // First button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            right: isOpen ? 0 : 0,
            bottom: isOpen ? 85 : 0,
            child: ElevatedButton(
              onPressed: () {
                // Handle first button action
              },
              style: _primaryButtonStyle(context),
              child: Icon(
                Icons.person_rounded,
                size: 28,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),

          // Second button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            right: isOpen ? 60 : 0,
            bottom: isOpen ? 60 : 0,
            child: ElevatedButton(
              onPressed: () {
                // Handle second button action
              },
              style: _primaryButtonStyle(context),
              child: Icon(
                Icons.bookmark_border_rounded,
                size: 28,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),

          // Third button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: isOpen ? 85 : 0,
            bottom: isOpen ? 0 : 0,
            child: ElevatedButton(
              onPressed: () {
                // Handle third button action
              },
              style: _primaryButtonStyle(context),
              child: Icon(
                Icons.add,
                size: 28,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),

          // Main button
          AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              style: _secondaryButtonStyle(context),
              child: SvgPicture.asset(
                'assets/logo/logo-dark-icon.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isOpen ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              style: _primaryButtonStyle(context),
              child: SvgPicture.asset(
                'assets/logo/logo-light-icon.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Styling for the buttons
  ButtonStyle _primaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: CircleBorder(),
      fixedSize: Size(56, 56),
      elevation: 2,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    );
  }

  ButtonStyle _secondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: CircleBorder(),
      fixedSize: Size(56, 56),
      elevation: 2,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    );
  }
}
