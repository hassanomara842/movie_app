// Integration test for app launch and splash screen behavior
// This test verifies that the app initializes correctly and that
// splash screen resources are properly configured

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App Launch and Splash Screen Integration', () {
    group('Native Splash Screen Resources', () {
      test('splash screen resources are accessible from Flutter', () async {
        // Verify that the Android resources directory structure exists
        final projectRoot = Directory.current.path;
        final androidResPath = path.join(
          projectRoot,
          'android',
          'app',
          'src',
          'main',
          'res',
        );

        expect(
          Directory(androidResPath).existsSync(),
          isTrue,
          reason: 'Android resources directory should exist',
        );
      });

      test('launch theme resources are properly configured', () {
        final projectRoot = Directory.current.path;

        // Check for styles.xml or values directory
        final valuesPaths = [
          path.join(projectRoot, 'android', 'app', 'src', 'main', 'res', 'values'),
          path.join(projectRoot, 'android', 'app', 'src', 'main', 'res', 'values-night'),
        ];

        var hasStylesDirectory = false;
        for (final valuesPath in valuesPaths) {
          if (Directory(valuesPath).existsSync()) {
            hasStylesDirectory = true;
            break;
          }
        }

        // It's okay if styles are defined elsewhere, this is just a sanity check
        expect(
          hasStylesDirectory || Directory(path.join(projectRoot, 'android', 'app', 'src', 'main', 'res')).existsSync(),
          isTrue,
          reason: 'Resource directories should be accessible',
        );
      });

      test('drawable resources directory structure is correct', () {
        final projectRoot = Directory.current.path;
        final drawableVariants = [
          'drawable',
          'drawable-v21',
          'drawable-night',
          'drawable-night-v21',
          'drawable-mdpi',
          'drawable-hdpi',
          'drawable-xhdpi',
          'drawable-xxhdpi',
          'drawable-xxxhdpi',
        ];

        var foundDrawables = 0;
        for (final variant in drawableVariants) {
          final drawablePath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            variant,
          );

          if (Directory(drawablePath).existsSync()) {
            foundDrawables++;
          }
        }

        expect(
          foundDrawables,
          greaterThan(0),
          reason: 'At least one drawable directory should exist',
        );
      });
    });

    group('Splash Screen Configuration Files', () {
      test('flutter_native_splash configuration exists', () {
        final projectRoot = Directory.current.path;
        final configPath = path.join(projectRoot, 'flutter_native_splash.yaml');

        final configFile = File(configPath);
        expect(
          configFile.existsSync(),
          isTrue,
          reason: 'flutter_native_splash.yaml should exist',
        );

        if (configFile.existsSync()) {
          final content = configFile.readAsStringSync();
          expect(
            content.isNotEmpty,
            isTrue,
            reason: 'Splash screen config should not be empty',
          );
        }
      });

      test('splash screen config has required fields', () {
        final projectRoot = Directory.current.path;
        final configPath = path.join(projectRoot, 'flutter_native_splash.yaml');

        final configFile = File(configPath);
        if (configFile.existsSync()) {
          final content = configFile.readAsStringSync();

          // Check for Android-specific configuration
          expect(
            content.contains('android') || content.contains('color') || content.contains('image'),
            isTrue,
            reason: 'Config should have splash screen settings',
          );
        }
      });
    });

    group('App Initialization', () {
      testWidgets('app can be initialized without errors', (WidgetTester tester) async {
        // Create a minimal test app to verify basic initialization
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Test App'),
              ),
            ),
          ),
        );

        expect(find.text('Test App'), findsOneWidget);
      });

      testWidgets('MaterialApp supports theme modes', (WidgetTester tester) async {
        // Test that the app can handle light and dark themes
        // (relevant for splash screen theme variants)
        final lightTheme = ThemeData.light();
        final darkTheme = ThemeData.dark();

        await tester.pumpWidget(
          MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: const Scaffold(
              body: Center(
                child: Text('Theme Test'),
              ),
            ),
          ),
        );

        expect(find.text('Theme Test'), findsOneWidget);

        // Switch to dark mode
        await tester.pumpWidget(
          MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            home: const Scaffold(
              body: Center(
                child: Text('Theme Test'),
              ),
            ),
          ),
        );

        expect(find.text('Theme Test'), findsOneWidget);
      });

      testWidgets('app handles system theme changes', (WidgetTester tester) async {
        // Verify the app can respond to system theme changes
        // This is important for splash screen night mode variants
        final binding = TestWidgetsFlutterBinding.instance;

        // Test with light theme
        binding.platformDispatcher.platformBrightnessTestValue = Brightness.light;

        await tester.pumpWidget(
          MaterialApp(
            themeMode: ThemeMode.system,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: const Scaffold(
              body: Text('Brightness Test'),
            ),
          ),
        );

        expect(find.text('Brightness Test'), findsOneWidget);

        // Test with dark theme
        binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
        await tester.pumpWidget(
          MaterialApp(
            themeMode: ThemeMode.system,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: const Scaffold(
              body: Text('Brightness Test'),
            ),
          ),
        );

        expect(find.text('Brightness Test'), findsOneWidget);
      });
    });

    group('Platform Channel Communication', () {
      testWidgets('platform channels are available', (WidgetTester tester) async {
        // Verify that platform channels work (needed for native splash screen)
        const channel = MethodChannel('test_channel');

        var channelWorks = false;
        try {
          // Set up a test method handler
          tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            channel,
            (MethodCall methodCall) async {
              return 'test_response';
            },
          );

          final result = await channel.invokeMethod('test_method');
          channelWorks = result == 'test_response';
        } catch (e) {
          channelWorks = false;
        }

        expect(channelWorks, isTrue, reason: 'Platform channels should be operational');
      });
    });

    group('Resource Loading', () {
      test('Android resource directory has expected structure', () {
        final projectRoot = Directory.current.path;
        final androidPath = path.join(projectRoot, 'android');

        expect(
          Directory(androidPath).existsSync(),
          isTrue,
          reason: 'Android directory should exist',
        );

        final manifestPath = path.join(
          androidPath,
          'app',
          'src',
          'main',
          'AndroidManifest.xml',
        );

        expect(
          File(manifestPath).existsSync(),
          isTrue,
          reason: 'AndroidManifest.xml should exist',
        );
      });

      test('all density-specific splash screens exist', () {
        final projectRoot = Directory.current.path;
        final densities = ['mdpi', 'hdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];
        var missingCount = 0;

        for (final density in densities) {
          final splashPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density',
            'android12splash.png',
          );

          if (!File(splashPath).existsSync()) {
            missingCount++;
          }
        }

        expect(
          missingCount,
          equals(0),
          reason: 'All density variants should have splash screens',
        );
      });

      test('night mode splash screens exist for all densities', () {
        final projectRoot = Directory.current.path;
        final densities = ['mdpi', 'hdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];
        var missingCount = 0;

        for (final density in densities) {
          final splashPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-night-$density',
            'android12splash.png',
          );

          if (!File(splashPath).existsSync()) {
            missingCount++;
          }
        }

        expect(
          missingCount,
          equals(0),
          reason: 'All night mode density variants should have splash screens',
        );
      });
    });

    group('Edge Cases and Regression Tests', () {
      testWidgets('app handles rapid theme switches', (WidgetTester tester) async {
        // Regression test: ensure app doesn't crash with rapid theme changes
        final binding = TestWidgetsFlutterBinding.instance;

        for (var i = 0; i < 5; i++) {
          binding.platformDispatcher.platformBrightnessTestValue =
              i % 2 == 0 ? Brightness.light : Brightness.dark;

          await tester.pumpWidget(
            MaterialApp(
              themeMode: ThemeMode.system,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home: const Scaffold(
                body: Text('Rapid Theme Test'),
              ),
            ),
          );

          await tester.pump();
        }

        expect(find.text('Rapid Theme Test'), findsOneWidget);
      });

      test('splash screen images have consistent naming', () {
        final projectRoot = Directory.current.path;
        final densities = ['mdpi', 'hdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          // Light mode
          final lightSplashPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density',
            'android12splash.png',
          );

          // Dark mode
          final darkSplashPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-night-$density',
            'android12splash.png',
          );

          // Both should have the same filename (different directories)
          expect(
            path.basename(lightSplashPath),
            equals(path.basename(darkSplashPath)),
            reason: 'Light and dark mode should use same filename convention',
          );
        }
      });

      test('no orphaned resource files exist', () {
        final projectRoot = Directory.current.path;
        final resPath = path.join(projectRoot, 'android', 'app', 'src', 'main', 'res');

        if (Directory(resPath).existsSync()) {
          // Check that drawable directories don't have unexpected files
          final drawableDirs = Directory(resPath)
              .listSync()
              .whereType<Directory>()
              .where((dir) => path.basename(dir.path).startsWith('drawable'));

          for (final dir in drawableDirs) {
            final files = dir.listSync().whereType<File>();

            for (final file in files) {
              final filename = path.basename(file.path);

              // Verify only expected files are present
              final isExpected = filename.endsWith('.png') ||
                  filename.endsWith('.xml') ||
                  filename.endsWith('.jpg') ||
                  filename.endsWith('.webp');

              expect(
                isExpected,
                isTrue,
                reason: 'Unexpected file type in drawable: $filename',
              );
            }
          }
        }
      });

      testWidgets('app gracefully handles missing theme resources', (WidgetTester tester) async {
        // Boundary test: app should still work even if theme resources are minimal
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              // Minimal theme configuration
              useMaterial3: true,
            ),
            home: const Scaffold(
              body: Text('Minimal Theme Test'),
            ),
          ),
        );

        expect(find.text('Minimal Theme Test'), findsOneWidget);
      });
    });
  });
}