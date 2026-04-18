import 'package:bike_rental/ui/screens/map_screen/map_screen.dart';
import 'package:bike_rental/ui/screens/pass_selection_screen/pass_selection_screen.dart';
import 'package:bike_rental/ui/screens/profile_screen/profile_screen.dart';
import 'package:bike_rental/ui/states/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/theme/theme.dart';

///
/// Launch the application with the given list of providers
///
void mainCommon(List<InheritedProvider> providers) {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MapScreen(),
    SubscriptionScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<AppThemeState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      darkTheme: darkTheme,
      themeMode: themeState.themeMode,
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership),
              label: 'Subscription',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
