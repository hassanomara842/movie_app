import 'package:flutter/material.dart';
import 'package:movie_app/provider/app_language_provider.dart';
import 'package:movie_app/provider/app_theme_provider.dart';
import 'package:movie_app/provider/shared_preferences_language.dart';
import 'package:movie_app/provider/shared_preferences_theme.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/theming/app_theme.dart';
import 'package:movie_app/core/responsive/size_config.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesLanguage.init();
  await SharedPreferencesTheme.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    
    return MaterialApp(
      title: 'Movie App',
      locale: Locale(languageProvider.appLocal),
      themeMode: themeProvider.appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      builder: (context, child) {
        SizeConfig.init(context);
        return child!;
      },
    );
  }
}
