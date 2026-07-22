import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/food_provider.dart';
import 'screens/auth_screen.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
    GoogleFonts.config.allowRuntimeFetching = true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Food Access',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthScreen(), // 4. Start with Auth Screen
    );
  }
}
