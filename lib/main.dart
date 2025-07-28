import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'theme_provider.dart';

import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/termsandconditions.dart';
import 'screens/dashboard.dart';
import 'screens/profile.dart';
import 'screens/classify.dart';
import 'screens/education.dart';
import 'screens/settings.dart';
import 'screens/aitanabot.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Africa/Nairobi'));
  debugPrint('TimeZone set to: ${tz.local}');

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const AitanaApp(),
    ),
  );
}

class AitanaApp extends StatelessWidget {
  const AitanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      title: 'Aitana – E-Waste Upcycling',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.lexendTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.lexendTextTheme(
          ThemeData.dark().textTheme,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/terms': (context) => const TermsAndConditionsScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/profile': (context) => ProfileScreen(),
        '/classify': (context) => const ClassifyScreen(),
        '/education': (context) => const EducationScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/aitanabot': (context) => const AitanaBotScreen(),
      },
    );
  }
}
