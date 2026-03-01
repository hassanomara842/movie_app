import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/theming/app_theme.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import 'package:movie_app/data/local/hive/movie_hive_model.dart';
import 'package:movie_app/data/local/hive/movies_cache_entry_hive_model.dart';
import 'di/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MovieHiveModelAdapter().typeId)) {
    Hive.registerAdapter(MovieHiveModelAdapter());
  }
  if (!Hive.isAdapterRegistered(MoviesCacheEntryHiveModelAdapter().typeId)) {
    Hive.registerAdapter(MoviesCacheEntryHiveModelAdapter());
  }

  configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Movie App',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: CacheHelper.getTheme(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.onBoardingScreen,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
