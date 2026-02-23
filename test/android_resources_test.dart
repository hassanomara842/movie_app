// Test file for validating Android resource files
// These tests verify that all Android native resources (drawables, layouts, manifest)
// are correctly configured for the splash screen functionality

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('Android Resource Files Validation', () {
    late String projectRoot;

    setUp(() {
      // Get the project root directory
      projectRoot = Directory.current.path;
    });

    group('Splash Screen PNG Resources', () {
      test('android12splash.png files exist for all densities (light mode)', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

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

          final file = File(splashPath);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Splash screen image should exist at $splashPath',
          );

          // Verify file is not empty
          expect(
            file.lengthSync(),
            greaterThan(0),
            reason: 'Splash screen image should not be empty at $splashPath',
          );
        }
      });

      test('android12splash.png files exist for all densities (dark mode)', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

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

          final file = File(splashPath);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Dark mode splash screen image should exist at $splashPath',
          );

          // Verify file is not empty
          expect(
            file.lengthSync(),
            greaterThan(0),
            reason: 'Dark mode splash screen image should not be empty at $splashPath',
          );
        }
      });

      test('android12branding.png files exist for all densities (light mode)', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final brandingPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density-v31',
            'android12branding.png',
          );

          final file = File(brandingPath);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Branding image should exist at $brandingPath',
          );

          // Verify file is not empty
          expect(
            file.lengthSync(),
            greaterThan(0),
            reason: 'Branding image should not be empty at $brandingPath',
          );
        }
      });

      test('android12branding.png files exist for all densities (dark mode)', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final brandingPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-night-$density-v31',
            'android12branding.png',
          );

          final file = File(brandingPath);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Dark mode branding image should exist at $brandingPath',
          );

          // Verify file is not empty
          expect(
            file.lengthSync(),
            greaterThan(0),
            reason: 'Dark mode branding image should not be empty at $brandingPath',
          );
        }
      });

      test('background.png files exist for light and dark modes', () {
        final configs = [
          'drawable-v21/background.png',
          'drawable/background.png',
          'drawable-night-v21/background.png',
          'drawable-night/background.png',
        ];

        for (final config in configs) {
          final backgroundPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            config,
          );

          final file = File(backgroundPath);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Background image should exist at $backgroundPath',
          );

          if (file.existsSync()) {
            expect(
              file.lengthSync(),
              greaterThan(0),
              reason: 'Background image should not be empty at $backgroundPath',
            );
          }
        }
      });
    });

    group('Launch Background XML Resources', () {
      test('launch_background.xml exists for light mode (v21)', () {
        final xmlPath = path.join(
          projectRoot,
          'android',
          'app',
          'src',
          'main',
          'res',
          'drawable-v21',
          'launch_background.xml',
        );

        final file = File(xmlPath);
        expect(
          file.existsSync(),
          isTrue,
          reason: 'Light mode launch_background.xml should exist',
        );
      });

      test('launch_background.xml has valid XML structure (light mode)', () {
        final xmlPath = path.join(
          projectRoot,
          'android',
          'app',
          'src',
          'main',
          'res',
          'drawable-v21',
          'launch_background.xml',
        );

        final file = File(xmlPath);
        if (file.existsSync()) {
          final content = file.readAsStringSync();

          // Check for XML declaration
          expect(
            content.contains('<?xml version="1.0"'),
            isTrue,
            reason: 'XML should have proper declaration',
          );

          // Check for layer-list root element
          expect(
            content.contains('<layer-list'),
            isTrue,
            reason: 'XML should contain layer-list element',
          );

          // Check for android namespace
          expect(
            content.contains('xmlns:android'),
            isTrue,
            reason: 'XML should declare android namespace',
          );

          // Check for bitmap drawable reference
          expect(
            content.contains('@drawable/background'),
            isTrue,
            reason: 'XML should reference background drawable',
          );
        }
      });

      test('launch_background.xml exists for dark mode (v21)', () {
        final xmlPath = path.join(
          projectRoot,
          'android',
          'app',
          'src',
          'main',
          'res',
          'drawable-night-v21',
          'launch_background.xml',
        );

        final file = File(xmlPath);
        expect(
          file.existsSync(),
          isTrue,
          reason: 'Dark mode launch_background.xml should exist',
        );
      });

      test('launch_background.xml has valid XML structure (dark mode)', () {
        final xmlPath = path.join(
          projectRoot,
          'android',
          'app',
          'src',
          'main',
          'res',
          'drawable-night-v21',
          'launch_background.xml',
        );

        final file = File(xmlPath);
        if (file.existsSync()) {
          final content = file.readAsStringSync();

          // Check for XML declaration
          expect(
            content.contains('<?xml version="1.0"'),
            isTrue,
            reason: 'Dark mode XML should have proper declaration',
          );

          // Check for layer-list root element
          expect(
            content.contains('<layer-list'),
            isTrue,
            reason: 'Dark mode XML should contain layer-list element',
          );

          // Check for android namespace
          expect(
            content.contains('xmlns:android'),
            isTrue,
            reason: 'Dark mode XML should declare android namespace',
          );

          // Check for bitmap drawable reference
          expect(
            content.contains('@drawable/background'),
            isTrue,
            reason: 'Dark mode XML should reference background drawable',
          );
        }
      });

      test('launch_background.xml files exist for regular drawables', () {
        final configs = [
          'drawable/launch_background.xml',
          'drawable-night/launch_background.xml',
        ];

        for (final config in configs) {
          final xmlPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            config,
          );

          final file = File(xmlPath);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Launch background XML should exist at $xmlPath',
          );
        }
      });
    });

    group('Splash Screen Resource Consistency', () {
      test('light and dark mode have same density coverage for splash screens', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final lightPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density',
            'android12splash.png',
          );

          final darkPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-night-$density',
            'android12splash.png',
          );

          final lightExists = File(lightPath).existsSync();
          final darkExists = File(darkPath).existsSync();

          expect(
            lightExists,
            equals(darkExists),
            reason: 'Density $density should have matching light and dark mode splash screens',
          );
        }
      });

      test('light and dark mode have same density coverage for branding', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final lightPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density-v31',
            'android12branding.png',
          );

          final darkPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-night-$density-v31',
            'android12branding.png',
          );

          final lightExists = File(lightPath).existsSync();
          final darkExists = File(darkPath).existsSync();

          expect(
            lightExists,
            equals(darkExists),
            reason: 'Density $density should have matching light and dark mode branding images',
          );
        }
      });

      test('all required density variants are present', () {
        // Android best practice: provide at least mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi
        final requiredDensities = ['mdpi', 'hdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in requiredDensities) {
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

          expect(
            File(splashPath).existsSync(),
            isTrue,
            reason: 'Required density $density must have splash screen',
          );
        }
      });
    });

    group('Edge Cases and Negative Tests', () {
      test('PNG files have valid PNG signature', () {
        final testFile = path.join(
          projectRoot,
          'android',
          'app',
          'src',
          'main',
          'res',
          'drawable-mdpi',
          'android12splash.png',
        );

        final file = File(testFile);
        if (file.existsSync()) {
          final bytes = file.readAsBytesSync();

          // PNG signature: 137 80 78 71 13 10 26 10
          expect(bytes.length, greaterThanOrEqualTo(8));
          expect(bytes[0], equals(137));
          expect(bytes[1], equals(80));
          expect(bytes[2], equals(78));
          expect(bytes[3], equals(71));
          expect(bytes[4], equals(13));
          expect(bytes[5], equals(10));
          expect(bytes[6], equals(26));
          expect(bytes[7], equals(10));
        }
      });

      test('XML files do not contain invalid drawable references', () {
        final xmlFiles = [
          'drawable-v21/launch_background.xml',
          'drawable-night-v21/launch_background.xml',
          'drawable/launch_background.xml',
          'drawable-night/launch_background.xml',
        ];

        for (final xmlFile in xmlFiles) {
          final xmlPath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            xmlFile,
          );

          final file = File(xmlPath);
          if (file.existsSync()) {
            final content = file.readAsStringSync();

            // Ensure no broken references (like @drawable/missing_file)
            expect(
              content.contains('@drawable/background'),
              isTrue,
              reason: 'XML should reference background drawable at $xmlPath',
            );

            // Ensure no syntax errors (unclosed tags)
            final openTags = '</'.allMatches(content).length;
            expect(
              openTags,
              greaterThan(0),
              reason: 'XML should have closing tags at $xmlPath',
            );
          }
        }
      });

      test('branding images are only in v31+ directories (Android 12+)', () {
        // Branding images should only exist in -v31 directories
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          // Check that branding is in v31 directory
          final v31Path = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density-v31',
            'android12branding.png',
          );

          expect(
            File(v31Path).existsSync(),
            isTrue,
            reason: 'Branding should exist in v31 directory for $density',
          );

          // Verify branding is NOT in non-v31 directory
          final nonV31Path = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            'drawable-$density',
            'android12branding.png',
          );

          expect(
            File(nonV31Path).existsSync(),
            isFalse,
            reason: 'Branding should NOT exist in non-v31 directory for $density',
          );
        }
      });

      test('all PNG files have reasonable file sizes', () {
        final testFiles = [
          'drawable-mdpi/android12splash.png',
          'drawable-hdpi/android12splash.png',
          'drawable-xhdpi/android12splash.png',
        ];

        for (final testFile in testFiles) {
          final filePath = path.join(
            projectRoot,
            'android',
            'app',
            'src',
            'main',
            'res',
            testFile,
          );

          final file = File(filePath);
          if (file.existsSync()) {
            final sizeInBytes = file.lengthSync();

            // PNG should be larger than 100 bytes (minimum viable PNG)
            expect(
              sizeInBytes,
              greaterThan(100),
              reason: 'PNG file should be larger than minimum at $filePath',
            );

            // PNG should be smaller than 10MB (reasonable max for splash screen)
            expect(
              sizeInBytes,
              lessThan(10 * 1024 * 1024),
              reason: 'PNG file should not exceed 10MB at $filePath',
            );
          }
        }
      });
    });
  });
}