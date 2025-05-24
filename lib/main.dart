import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_next/screens/danger_alert_screen.dart';
import 'package:otp_next/screens/panoramic_viewer_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav_bar.dart';
import 'screens/home_screen.dart';
import 'screens/payments_screen.dart';
import 'screens/products_screen.dart';
import 'screens/more_screen.dart';
import 'screens/digitalna_poslovnica_screen.dart';

void main() {
  runApp(const OtpGoApp());
}

class OtpGoApp extends StatelessWidget {
  const OtpGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'otpGo',
      theme: AppTheme.darkTheme,
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openDigitalnaPoslovnica() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PanoramicViewerScreen()),
    );
  }

  void _openDangerAlert() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DangerAlertScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final screens = [
      HomeScreen(onDigitalnaPoslovnica: _openDigitalnaPoslovnica),
      const PaymentsScreen(),
      ProductsScreen(onDangerAlert: _openDangerAlert,),
      const MoreScreen(),
    ];
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
