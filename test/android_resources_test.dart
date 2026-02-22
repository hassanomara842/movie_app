import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Android Drawable Resources Tests', () {
    const String androidResPath = 'android/app/src/main/res';

    group('Splash Screen Resources - HDPI', () {
      test('android12splash.png exists in drawable-hdpi', () {
        final file = File('$androidResPath/drawable-hdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'HDPI splash screen image should exist');
      });

      test('android12splash.png exists in drawable-night-hdpi', () {
        final file =
            File('$androidResPath/drawable-night-hdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'HDPI night mode splash screen image should exist');
      });
    });

    group('Splash Screen Resources - MDPI', () {
      test('android12splash.png exists in drawable-mdpi', () {
        final file = File('$androidResPath/drawable-mdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'MDPI splash screen image should exist');
      });

      test('android12splash.png exists in drawable-night-mdpi', () {
        final file =
            File('$androidResPath/drawable-night-mdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'MDPI night mode splash screen image should exist');
      });
    });

    group('Splash Screen Resources - XHDPI', () {
      test('android12splash.png exists in drawable-xhdpi', () {
        final file = File('$androidResPath/drawable-xhdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'XHDPI splash screen image should exist');
      });

      test('android12splash.png exists in drawable-night-xhdpi', () {
        final file =
            File('$androidResPath/drawable-night-xhdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'XHDPI night mode splash screen image should exist');
      });
    });

    group('Splash Screen Resources - XXHDPI', () {
      test('android12splash.png exists in drawable-xxhdpi', () {
        final file =
            File('$androidResPath/drawable-xxhdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'XXHDPI splash screen image should exist');
      });

      test('android12splash.png exists in drawable-night-xxhdpi', () {
        final file =
            File('$androidResPath/drawable-night-xxhdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'XXHDPI night mode splash screen image should exist');
      });
    });

    group('Splash Screen Resources - XXXHDPI', () {
      test('android12splash.png exists in drawable-xxxhdpi', () {
        final file =
            File('$androidResPath/drawable-xxxhdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'XXXHDPI splash screen image should exist');
      });

      test('android12splash.png exists in drawable-night-xxxhdpi', () {
        final file =
            File('$androidResPath/drawable-night-xxxhdpi/android12splash.png');
        expect(file.existsSync(), isTrue,
            reason: 'XXXHDPI night mode splash screen image should exist');
      });
    });

    group('Branding Resources - HDPI API 31+', () {
      test('android12branding.png exists in drawable-hdpi-v31', () {
        final file =
            File('$androidResPath/drawable-hdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'HDPI Android 12+ branding image should exist');
      });

      test('android12branding.png exists in drawable-night-hdpi-v31', () {
        final file = File(
            '$androidResPath/drawable-night-hdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'HDPI night mode Android 12+ branding image should exist');
      });
    });

    group('Branding Resources - MDPI API 31+', () {
      test('android12branding.png exists in drawable-mdpi-v31', () {
        final file =
            File('$androidResPath/drawable-mdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'MDPI Android 12+ branding image should exist');
      });

      test('android12branding.png exists in drawable-night-mdpi-v31', () {
        final file = File(
            '$androidResPath/drawable-night-mdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'MDPI night mode Android 12+ branding image should exist');
      });
    });

    group('Branding Resources - XHDPI API 31+', () {
      test('android12branding.png exists in drawable-xhdpi-v31', () {
        final file =
            File('$androidResPath/drawable-xhdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'XHDPI Android 12+ branding image should exist');
      });

      test('android12branding.png exists in drawable-night-xhdpi-v31', () {
        final file = File(
            '$androidResPath/drawable-night-xhdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'XHDPI night mode Android 12+ branding image should exist');
      });
    });

    group('Branding Resources - XXHDPI API 31+', () {
      test('android12branding.png exists in drawable-xxhdpi-v31', () {
        final file =
            File('$androidResPath/drawable-xxhdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'XXHDPI Android 12+ branding image should exist');
      });

      test('android12branding.png exists in drawable-night-xxhdpi-v31', () {
        final file = File(
            '$androidResPath/drawable-night-xxhdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason:
                'XXHDPI night mode Android 12+ branding image should exist');
      });
    });

    group('Branding Resources - XXXHDPI API 31+', () {
      test('android12branding.png exists in drawable-xxxhdpi-v31', () {
        final file =
            File('$androidResPath/drawable-xxxhdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason: 'XXXHDPI Android 12+ branding image should exist');
      });

      test('android12branding.png exists in drawable-night-xxxhdpi-v31', () {
        final file = File(
            '$androidResPath/drawable-night-xxxhdpi-v31/android12branding.png');
        expect(file.existsSync(), isTrue,
            reason:
                'XXXHDPI night mode Android 12+ branding image should exist');
      });
    });

    group('Background Resources - API 21+', () {
      test('background.png exists in drawable-v21', () {
        final file = File('$androidResPath/drawable-v21/background.png');
        expect(file.existsSync(), isTrue,
            reason: 'API 21+ background image should exist');
      });

      test('background.png exists in drawable-night-v21', () {
        final file = File('$androidResPath/drawable-night-v21/background.png');
        expect(file.existsSync(), isTrue,
            reason: 'Night mode API 21+ background image should exist');
      });

      test('background.png exists in drawable-night', () {
        final file = File('$androidResPath/drawable-night/background.png');
        expect(file.existsSync(), isTrue,
            reason: 'Night mode background image should exist');
      });
    });

    group('Launch Background XML Resources - API 21+', () {
      test('launch_background.xml exists in drawable-v21', () {
        final file = File('$androidResPath/drawable-v21/launch_background.xml');
        expect(file.existsSync(), isTrue,
            reason: 'API 21+ launch background XML should exist');
      });

      test('launch_background.xml is valid XML in drawable-v21', () {
        final file = File('$androidResPath/drawable-v21/launch_background.xml');
        final content = file.readAsStringSync();

        expect(content.contains('<?xml version="1.0" encoding="utf-8"?>'),
            isTrue,
            reason: 'XML should have proper declaration');
        expect(content.contains('<layer-list'), isTrue,
            reason: 'Should contain layer-list element');
        expect(content.contains('xmlns:android'), isTrue,
            reason: 'Should declare android namespace');
        expect(content.contains('@drawable/background'), isTrue,
            reason: 'Should reference background drawable');
      });

      test('launch_background.xml exists in drawable-night-v21', () {
        final file =
            File('$androidResPath/drawable-night-v21/launch_background.xml');
        expect(file.existsSync(), isTrue,
            reason: 'Night mode API 21+ launch background XML should exist');
      });

      test('launch_background.xml is valid XML in drawable-night-v21', () {
        final file =
            File('$androidResPath/drawable-night-v21/launch_background.xml');
        final content = file.readAsStringSync();

        expect(content.contains('<?xml version="1.0" encoding="utf-8"?>'),
            isTrue,
            reason: 'XML should have proper declaration');
        expect(content.contains('<layer-list'), isTrue,
            reason: 'Should contain layer-list element');
        expect(content.contains('xmlns:android'), isTrue,
            reason: 'Should declare android namespace');
        expect(content.contains('@drawable/background'), isTrue,
            reason: 'Should reference background drawable');
      });

      test('launch_background.xml exists in drawable-night', () {
        final file =
            File('$androidResPath/drawable-night/launch_background.xml');
        expect(file.existsSync(), isTrue,
            reason: 'Night mode launch background XML should exist');
      });

      test('launch_background.xml is valid XML in drawable-night', () {
        final file =
            File('$androidResPath/drawable-night/launch_background.xml');
        final content = file.readAsStringSync();

        expect(content.contains('<?xml version="1.0" encoding="utf-8"?>'),
            isTrue,
            reason: 'XML should have proper declaration');
        expect(content.contains('<layer-list'), isTrue,
            reason: 'Should contain layer-list element');
        expect(content.contains('xmlns:android'), isTrue,
            reason: 'Should declare android namespace');
        expect(content.contains('@drawable/background'), isTrue,
            reason: 'Should reference background drawable');
      });
    });

    group('Resource File Size Validation', () {
      test('all PNG files are non-empty', () {
        final pngFiles = [
          '$androidResPath/drawable-hdpi/android12splash.png',
          '$androidResPath/drawable-mdpi/android12splash.png',
          '$androidResPath/drawable-xhdpi/android12splash.png',
          '$androidResPath/drawable-xxhdpi/android12splash.png',
          '$androidResPath/drawable-xxxhdpi/android12splash.png',
          '$androidResPath/drawable-night-hdpi/android12splash.png',
          '$androidResPath/drawable-night-mdpi/android12splash.png',
          '$androidResPath/drawable-night-xhdpi/android12splash.png',
          '$androidResPath/drawable-night-xxhdpi/android12splash.png',
          '$androidResPath/drawable-night-xxxhdpi/android12splash.png',
          '$androidResPath/drawable-hdpi-v31/android12branding.png',
          '$androidResPath/drawable-mdpi-v31/android12branding.png',
          '$androidResPath/drawable-xhdpi-v31/android12branding.png',
          '$androidResPath/drawable-xxhdpi-v31/android12branding.png',
          '$androidResPath/drawable-xxxhdpi-v31/android12branding.png',
          '$androidResPath/drawable-night-hdpi-v31/android12branding.png',
          '$androidResPath/drawable-night-mdpi-v31/android12branding.png',
          '$androidResPath/drawable-night-xhdpi-v31/android12branding.png',
          '$androidResPath/drawable-night-xxhdpi-v31/android12branding.png',
          '$androidResPath/drawable-night-xxxhdpi-v31/android12branding.png',
          '$androidResPath/drawable-v21/background.png',
          '$androidResPath/drawable-night-v21/background.png',
          '$androidResPath/drawable-night/background.png',
        ];

        for (final path in pngFiles) {
          final file = File(path);
          if (file.existsSync()) {
            final size = file.lengthSync();
            expect(size, greaterThan(0),
                reason: '$path should not be empty (size: $size bytes)');
          }
        }
      });

      test('PNG files have valid PNG header', () {
        final pngFiles = [
          '$androidResPath/drawable-hdpi/android12splash.png',
          '$androidResPath/drawable-mdpi/android12splash.png',
          '$androidResPath/drawable-xhdpi/android12splash.png',
          '$androidResPath/drawable-xxhdpi/android12splash.png',
        ];

        for (final path in pngFiles) {
          final file = File(path);
          if (file.existsSync()) {
            final bytes = file.readAsBytesSync();
            // PNG magic number: 0x89 0x50 0x4E 0x47 0x0D 0x0A 0x1A 0x0A
            expect(bytes.length, greaterThanOrEqualTo(8),
                reason: '$path should have at least 8 bytes for PNG header');
            expect(bytes[0], equals(0x89),
                reason: '$path should start with PNG magic number');
            expect(bytes[1], equals(0x50),
                reason: '$path should have correct PNG signature');
            expect(bytes[2], equals(0x4E),
                reason: '$path should have correct PNG signature');
            expect(bytes[3], equals(0x47),
                reason: '$path should have correct PNG signature');
          }
        }
      });
    });

    group('Resource Density Coverage', () {
      test('all density variants exist for android12splash.png', () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final file =
              File('$androidResPath/drawable-$density/android12splash.png');
          expect(file.existsSync(), isTrue,
              reason:
                  'android12splash.png should exist for density: $density');
        }
      });

      test('all night mode density variants exist for android12splash.png',
          () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final file = File(
              '$androidResPath/drawable-night-$density/android12splash.png');
          expect(file.existsSync(), isTrue,
              reason:
                  'android12splash.png should exist for night mode density: $density');
        }
      });

      test('all density variants exist for android12branding.png (API 31+)',
          () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final file = File(
              '$androidResPath/drawable-$density-v31/android12branding.png');
          expect(file.existsSync(), isTrue,
              reason:
                  'android12branding.png should exist for density: $density-v31');
        }
      });

      test(
          'all night mode density variants exist for android12branding.png (API 31+)',
          () {
        final densities = ['hdpi', 'mdpi', 'xhdpi', 'xxhdpi', 'xxxhdpi'];

        for (final density in densities) {
          final file = File(
              '$androidResPath/drawable-night-$density-v31/android12branding.png');
          expect(file.existsSync(), isTrue,
              reason:
                  'android12branding.png should exist for night mode density: $density-v31');
        }
      });
    });

    group('Night Mode Resource Coverage', () {
      test('all splash screen resources have night mode variants', () {
        final lightModeFiles = [
          'drawable-hdpi/android12splash.png',
          'drawable-mdpi/android12splash.png',
          'drawable-xhdpi/android12splash.png',
          'drawable-xxhdpi/android12splash.png',
          'drawable-xxxhdpi/android12splash.png',
        ];

        for (final lightPath in lightModeFiles) {
          final nightPath = lightPath.replaceFirst('drawable-', 'drawable-night-');
          final nightFile = File('$androidResPath/$nightPath');
          expect(nightFile.existsSync(), isTrue,
              reason:
                  'Night mode variant should exist for $lightPath at $nightPath');
        }
      });

      test('all branding resources have night mode variants', () {
        final lightModeFiles = [
          'drawable-hdpi-v31/android12branding.png',
          'drawable-mdpi-v31/android12branding.png',
          'drawable-xhdpi-v31/android12branding.png',
          'drawable-xxhdpi-v31/android12branding.png',
          'drawable-xxxhdpi-v31/android12branding.png',
        ];

        for (final lightPath in lightModeFiles) {
          final nightPath = lightPath.replaceFirst('drawable-', 'drawable-night-');
          final nightFile = File('$androidResPath/$nightPath');
          expect(nightFile.existsSync(), isTrue,
              reason:
                  'Night mode variant should exist for $lightPath at $nightPath');
        }
      });

      test('background and launch_background have night mode variants', () {
        final lightModeFiles = [
          'drawable-v21/background.png',
          'drawable-v21/launch_background.xml',
        ];

        for (final lightPath in lightModeFiles) {
          final nightPath = lightPath.replaceFirst('drawable-', 'drawable-night-');
          final nightFile = File('$androidResPath/$nightPath');
          expect(nightFile.existsSync(), isTrue,
              reason:
                  'Night mode variant should exist for $lightPath at $nightPath');
        }
      });
    });

    group('XML Structure Validation', () {
      test('all launch_background.xml files reference the background drawable',
          () {
        final xmlFiles = [
          '$androidResPath/drawable-v21/launch_background.xml',
          '$androidResPath/drawable-night-v21/launch_background.xml',
          '$androidResPath/drawable-night/launch_background.xml',
        ];

        for (final path in xmlFiles) {
          final file = File(path);
          if (file.existsSync()) {
            final content = file.readAsStringSync();
            expect(content.contains('<item>'), isTrue,
                reason: '$path should contain item elements');
            expect(content.contains('<bitmap'), isTrue,
                reason: '$path should contain bitmap element');
            expect(content.contains('android:gravity="fill"'), isTrue,
                reason: '$path should specify gravity attribute');
            expect(content.contains('android:src="@drawable/background"'),
                isTrue,
                reason: '$path should reference background drawable');
          }
        }
      });

      test('all launch_background.xml files are well-formed', () {
        final xmlFiles = [
          '$androidResPath/drawable-v21/launch_background.xml',
          '$androidResPath/drawable-night-v21/launch_background.xml',
          '$androidResPath/drawable-night/launch_background.xml',
        ];

        for (final path in xmlFiles) {
          final file = File(path);
          if (file.existsSync()) {
            final content = file.readAsStringSync();

            // Count opening and closing tags
            final layerListOpen = '<layer-list'.allMatches(content).length;
            final layerListClose = '</layer-list>'.allMatches(content).length;
            expect(layerListOpen, equals(layerListClose),
                reason:
                    '$path should have matching layer-list opening and closing tags');

            // Verify proper XML structure
            expect(content.trim().endsWith('</layer-list>'), isTrue,
                reason: '$path should end with closing layer-list tag');
          }
        }
      });
    });

    group('API Level Resource Configuration', () {
      test('Android 12 (API 31) specific resources are in v31 directories', () {
        final v31Directories = [
          'drawable-hdpi-v31',
          'drawable-mdpi-v31',
          'drawable-xhdpi-v31',
          'drawable-xxhdpi-v31',
          'drawable-xxxhdpi-v31',
          'drawable-night-hdpi-v31',
          'drawable-night-mdpi-v31',
          'drawable-night-xhdpi-v31',
          'drawable-night-xxhdpi-v31',
          'drawable-night-xxxhdpi-v31',
        ];

        for (final dir in v31Directories) {
          final file = File('$androidResPath/$dir/android12branding.png');
          expect(file.existsSync(), isTrue,
              reason:
                  'android12branding.png should exist in API 31+ directory: $dir');
        }
      });

      test('API 21 specific resources are in v21 directories', () {
        final v21Files = [
          '$androidResPath/drawable-v21/background.png',
          '$androidResPath/drawable-v21/launch_background.xml',
          '$androidResPath/drawable-night-v21/background.png',
          '$androidResPath/drawable-night-v21/launch_background.xml',
        ];

        for (final path in v21Files) {
          final file = File(path);
          expect(file.existsSync(), isTrue,
              reason: 'API 21+ resource should exist at $path');
        }
      });
    });

    group('Resource Consistency Tests', () {
      test('splash screen files exist across all required configurations', () {
        // Test that we have complete coverage for splash screens
        final requiredConfigs = [
          'drawable-hdpi',
          'drawable-mdpi',
          'drawable-xhdpi',
          'drawable-xxhdpi',
          'drawable-xxxhdpi',
          'drawable-night-hdpi',
          'drawable-night-mdpi',
          'drawable-night-xhdpi',
          'drawable-night-xxhdpi',
          'drawable-night-xxxhdpi',
        ];

        var missingCount = 0;
        final missingConfigs = <String>[];

        for (final config in requiredConfigs) {
          final file =
              File('$androidResPath/$config/android12splash.png');
          if (!file.existsSync()) {
            missingCount++;
            missingConfigs.add(config);
          }
        }

        expect(missingCount, equals(0),
            reason:
                'All splash screen configurations should exist. Missing: $missingConfigs');
      });

      test('branding files exist across all required Android 12+ configurations',
          () {
        // Test that we have complete coverage for Android 12+ branding
        final requiredConfigs = [
          'drawable-hdpi-v31',
          'drawable-mdpi-v31',
          'drawable-xhdpi-v31',
          'drawable-xxhdpi-v31',
          'drawable-xxxhdpi-v31',
          'drawable-night-hdpi-v31',
          'drawable-night-mdpi-v31',
          'drawable-night-xhdpi-v31',
          'drawable-night-xxhdpi-v31',
          'drawable-night-xxxhdpi-v31',
        ];

        var missingCount = 0;
        final missingConfigs = <String>[];

        for (final config in requiredConfigs) {
          final file =
              File('$androidResPath/$config/android12branding.png');
          if (!file.existsSync()) {
            missingCount++;
            missingConfigs.add(config);
          }
        }

        expect(missingCount, equals(0),
            reason:
                'All Android 12+ branding configurations should exist. Missing: $missingConfigs');
      });
    });

    group('Regression Tests', () {
      test('drawable resource files have not been accidentally corrupted', () {
        // Check that XML files are not empty or corrupted
        final xmlFiles = [
          '$androidResPath/drawable-v21/launch_background.xml',
          '$androidResPath/drawable-night-v21/launch_background.xml',
          '$androidResPath/drawable-night/launch_background.xml',
        ];

        for (final path in xmlFiles) {
          final file = File(path);
          if (file.existsSync()) {
            final content = file.readAsStringSync();
            expect(content.length, greaterThan(50),
                reason: '$path appears to be too short or corrupted');
            expect(content.contains('layer-list'), isTrue,
                reason: '$path should contain layer-list element');
          }
        }
      });

      test('PNG files are not zero-byte files', () {
        final testPaths = [
          '$androidResPath/drawable-hdpi/android12splash.png',
          '$androidResPath/drawable-v21/background.png',
          '$androidResPath/drawable-night/background.png',
        ];

        for (final path in testPaths) {
          final file = File(path);
          if (file.existsSync()) {
            expect(file.lengthSync(), greaterThan(0),
                reason: '$path should not be a zero-byte file');
          }
        }
      });

      test('resource files have reasonable file sizes', () {
        // Ensure PNG files are not suspiciously small (likely corrupted)
        // or suspiciously large (may cause memory issues)
        final testPaths = [
          '$androidResPath/drawable-hdpi/android12splash.png',
          '$androidResPath/drawable-xhdpi/android12splash.png',
        ];

        const minSize = 100; // 100 bytes minimum
        const maxSize = 10 * 1024 * 1024; // 10MB maximum

        for (final path in testPaths) {
          final file = File(path);
          if (file.existsSync()) {
            final size = file.lengthSync();
            expect(size, greaterThan(minSize),
                reason: '$path is too small ($size bytes), may be corrupted');
            expect(size, lessThan(maxSize),
                reason:
                    '$path is too large ($size bytes), may cause memory issues');
          }
        }
      });
    });

    group('Boundary and Edge Cases', () {
      test('handles missing optional density variants gracefully', () {
        // Some devices may use fallback densities
        // This test verifies at minimum the most common densities exist
        final criticalDensities = ['mdpi', 'hdpi', 'xhdpi', 'xxhdpi'];

        for (final density in criticalDensities) {
          final file =
              File('$androidResPath/drawable-$density/android12splash.png');
          expect(file.existsSync(), isTrue,
              reason:
                  'Critical density $density must have splash screen resource');
        }
      });

      test('XML files have consistent encoding declaration', () {
        final xmlFiles = [
          '$androidResPath/drawable-v21/launch_background.xml',
          '$androidResPath/drawable-night-v21/launch_background.xml',
          '$androidResPath/drawable-night/launch_background.xml',
        ];

        for (final path in xmlFiles) {
          final file = File(path);
          if (file.existsSync()) {
            final content = file.readAsStringSync();
            // Verify UTF-8 encoding is declared
            expect(content.contains('encoding="utf-8"'), isTrue,
                reason: '$path should declare UTF-8 encoding');
          }
        }
      });

      test('night mode resources exist as separate files (not symlinks)', () {
        final nightModeFiles = [
          '$androidResPath/drawable-night-hdpi/android12splash.png',
          '$androidResPath/drawable-night-v21/background.png',
        ];

        for (final path in nightModeFiles) {
          final file = File(path);
          if (file.existsSync()) {
            // Verify it's an actual file and not just a symbolic link
            final stat = file.statSync();
            expect(stat.type, isNot(FileSystemEntityType.link),
                reason: '$path should be an actual file, not a symlink');
          }
        }
      });
    });
  });
}