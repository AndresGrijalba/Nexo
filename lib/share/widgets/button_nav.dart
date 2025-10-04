import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nexo/features/settings/screens/settings_screen.dart';
import '../../features/home/screens/home_screen.dart';

class FloatingIconBarScaffold extends StatefulWidget {
  const FloatingIconBarScaffold({super.key});

  @override
  State<FloatingIconBarScaffold> createState() => _FloatingIconBarScaffoldState();
}

class _FloatingIconBarScaffoldState extends State<FloatingIconBarScaffold> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    Placeholder(), // Agenda
    Placeholder(), // Horario
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18, left: 32, right: 32),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withAlpha(300),
                ),
              ),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                      icon: _selectedIndex == 0
                          ? HugeIcon(
                        icon: HugeIcons.strokeRoundedHome03,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      )
                          : HugeIcon(
                        icon: HugeIcons.strokeRoundedHome03,
                        size: 28,
                      ),
                      onPressed: () => _onItemTapped(0),
                    ),
                    IconButton(
                      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                      icon: _selectedIndex == 1
                          ? HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar02,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      )
                          : HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar02,
                        size: 28,
                      ),
                      onPressed: () => _onItemTapped(1),
                    ),
                    IconButton(
                      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                      icon: _selectedIndex == 2
                          ? HugeIcon(
                        icon: HugeIcons.strokeRoundedAnalytics02,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      )
                          : HugeIcon(
                        icon: HugeIcons.strokeRoundedAnalytics02,
                        size: 28,
                      ),
                      onPressed: () => _onItemTapped(2),
                    ),
                    IconButton(
                      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                      icon: _selectedIndex == 3
                          ? HugeIcon(
                        icon: HugeIcons.strokeRoundedAiBook,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      )
                          : HugeIcon(
                        icon: HugeIcons.strokeRoundedAiBook,
                        size: 28,
                      ),
                      onPressed: () => _onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}