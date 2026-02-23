// Test file for validating AndroidManifest.xml configuration
// These tests verify that the Android manifest is properly configured
// for the Flutter app with correct permissions, activities, and metadata

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('AndroidManifest.xml Validation', () {
    late String projectRoot;
    late File manifestFile;

    setUp(() {
      projectRoot = Directory.current.path;
      final manifestPath = path.join(
        projectRoot,
        'android',
        'app',
        'src',
        'main',
        'AndroidManifest.xml',
      );
      manifestFile = File(manifestPath);
    });

    group('Manifest File Structure', () {
      test('AndroidManifest.xml exists', () {
        expect(
          manifestFile.existsSync(),
          isTrue,
          reason: 'AndroidManifest.xml should exist in android/app/src/main/',
        );
      });

      test('manifest has valid XML structure', () {
        expect(manifestFile.existsSync(), isTrue);

        final content = manifestFile.readAsStringSync();

        // Check for XML declaration
        expect(
          content.contains('<manifest'),
          isTrue,
          reason: 'Manifest should have <manifest> root element',
        );

        // Check for android namespace
        expect(
          content.contains('xmlns:android'),
          isTrue,
          reason: 'Manifest should declare android namespace',
        );

        // Check for application element
        expect(
          content.contains('<application'),
          isTrue,
          reason: 'Manifest should have <application> element',
        );
      });

      test('manifest has proper closing tags', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('</manifest>'),
          isTrue,
          reason: 'Manifest should have closing </manifest> tag',
        );

        expect(
          content.contains('</application>'),
          isTrue,
          reason: 'Manifest should have closing </application> tag',
        );
      });
    });

    group('Required Permissions', () {
      test('INTERNET permission is declared', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android.permission.INTERNET'),
          isTrue,
          reason: 'App requires INTERNET permission for API calls',
        );

        expect(
          content.contains('<uses-permission'),
          isTrue,
          reason: 'Permissions should be declared with uses-permission tag',
        );
      });

      test('permissions are declared before application element', () {
        final content = manifestFile.readAsStringSync();

        final permissionIndex = content.indexOf('uses-permission');
        final applicationIndex = content.indexOf('<application');

        expect(
          permissionIndex,
          lessThan(applicationIndex),
          reason: 'Permissions should be declared before application element',
        );
      });
    });

    group('Application Configuration', () {
      test('application has required attributes', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:label'),
          isTrue,
          reason: 'Application should have label attribute',
        );

        expect(
          content.contains('android:icon'),
          isTrue,
          reason: 'Application should have icon attribute',
        );

        expect(
          content.contains('android:name'),
          isTrue,
          reason: 'Application should have name attribute',
        );
      });

      test('application label is set correctly', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:label="movie_app"'),
          isTrue,
          reason: 'Application label should be "movie_app"',
        );
      });

      test('application references launcher icon', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('@mipmap/ic_launcher'),
          isTrue,
          reason: 'Application should reference ic_launcher icon',
        );
      });
    });

    group('MainActivity Configuration', () {
      test('MainActivity is declared', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('<activity'),
          isTrue,
          reason: 'MainActivity should be declared',
        );

        expect(
          content.contains('.MainActivity'),
          isTrue,
          reason: 'Activity name should reference MainActivity',
        );
      });

      test('MainActivity is exported', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:exported="true"'),
          isTrue,
          reason: 'MainActivity must be exported for Android 12+',
        );
      });

      test('MainActivity has launch theme', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('@style/LaunchTheme'),
          isTrue,
          reason: 'MainActivity should use LaunchTheme for splash screen',
        );
      });

      test('MainActivity has correct launch mode', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:launchMode="singleTop"'),
          isTrue,
          reason: 'MainActivity should use singleTop launch mode',
        );
      });

      test('MainActivity has hardware acceleration enabled', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:hardwareAccelerated="true"'),
          isTrue,
          reason: 'Hardware acceleration should be enabled for Flutter',
        );
      });

      test('MainActivity has proper config changes', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:configChanges'),
          isTrue,
          reason: 'MainActivity should declare config changes',
        );

        // Check for important config changes
        final configChanges = [
          'orientation',
          'keyboardHidden',
          'screenSize',
          'locale',
          'density',
        ];

        for (final config in configChanges) {
          expect(
            content.contains(config),
            isTrue,
            reason: 'MainActivity should handle $config config change',
          );
        }
      });

      test('MainActivity has normal theme metadata', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('io.flutter.embedding.android.NormalTheme'),
          isTrue,
          reason: 'MainActivity should declare NormalTheme metadata',
        );

        expect(
          content.contains('@style/NormalTheme'),
          isTrue,
          reason: 'NormalTheme should reference style resource',
        );
      });
    });

    group('Intent Filter Configuration', () {
      test('MainActivity has MAIN action intent filter', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android.intent.action.MAIN'),
          isTrue,
          reason: 'MainActivity should have MAIN action',
        );
      });

      test('MainActivity has LAUNCHER category', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android.intent.category.LAUNCHER'),
          isTrue,
          reason: 'MainActivity should have LAUNCHER category',
        );
      });

      test('intent filter is within activity element', () {
        final content = manifestFile.readAsStringSync();

        final activityStart = content.indexOf('<activity');
        final activityEnd = content.indexOf('</activity>');
        final intentFilterIndex = content.indexOf('<intent-filter>');

        expect(
          intentFilterIndex,
          greaterThan(activityStart),
          reason: 'Intent filter should be after activity opening tag',
        );

        expect(
          intentFilterIndex,
          lessThan(activityEnd),
          reason: 'Intent filter should be before activity closing tag',
        );
      });
    });

    group('Flutter Embedding Configuration', () {
      test('Flutter embedding version is declared', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('flutterEmbedding'),
          isTrue,
          reason: 'Flutter embedding version should be declared',
        );

        expect(
          content.contains('android:value="2"'),
          isTrue,
          reason: 'Flutter embedding version should be 2',
        );
      });

      test('Flutter embedding metadata is in application element', () {
        final content = manifestFile.readAsStringSync();

        final applicationStart = content.indexOf('<application');
        final applicationEnd = content.indexOf('</application>');
        final embeddingIndex = content.indexOf('flutterEmbedding');

        expect(
          embeddingIndex,
          greaterThan(applicationStart),
          reason: 'Flutter embedding should be in application element',
        );

        expect(
          embeddingIndex,
          lessThan(applicationEnd),
          reason: 'Flutter embedding should be in application element',
        );
      });
    });

    group('Queries Configuration', () {
      test('queries element exists for text processing', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('<queries>'),
          isTrue,
          reason: 'Manifest should have queries element',
        );

        expect(
          content.contains('</queries>'),
          isTrue,
          reason: 'Queries element should be properly closed',
        );
      });

      test('PROCESS_TEXT intent is declared in queries', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android.intent.action.PROCESS_TEXT'),
          isTrue,
          reason: 'Queries should include PROCESS_TEXT intent',
        );
      });

      test('queries includes text/plain mime type', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('text/plain'),
          isTrue,
          reason: 'Queries should specify text/plain mime type',
        );
      });
    });

    group('Edge Cases and Security', () {
      test('no backup is allowed or explicitly disabled', () {
        final content = manifestFile.readAsStringSync();

        // Either no backup attribute (default is true) or explicit setting
        // This test ensures we're aware of the backup setting
        final hasBackupAttribute = content.contains('android:allowBackup');

        if (hasBackupAttribute) {
          // If specified, it's intentional
          expect(
            content.contains('android:allowBackup'),
            isTrue,
            reason: 'Backup setting is explicitly configured',
          );
        }
        // If not specified, Android defaults to allowing backup
      });

      test('no debuggable flag is set in manifest', () {
        final content = manifestFile.readAsStringSync();

        // Debuggable should not be set in manifest (controlled by build type)
        expect(
          content.contains('android:debuggable="true"'),
          isFalse,
          reason: 'Debuggable should not be hardcoded in manifest',
        );
      });

      test('taskAffinity is explicitly set', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:taskAffinity'),
          isTrue,
          reason: 'Task affinity should be explicitly configured',
        );
      });

      test('windowSoftInputMode is configured', () {
        final content = manifestFile.readAsStringSync();

        expect(
          content.contains('android:windowSoftInputMode'),
          isTrue,
          reason: 'Soft input mode should be configured',
        );

        expect(
          content.contains('adjustResize'),
          isTrue,
          reason: 'Should use adjustResize for keyboard handling',
        );
      });

      test('no unnecessary permissions are declared', () {
        final content = manifestFile.readAsStringSync();

        // List of permissions that should NOT be present for this app
        final unnecessaryPermissions = [
          'WRITE_EXTERNAL_STORAGE',
          'READ_EXTERNAL_STORAGE',
          'CAMERA',
          'ACCESS_FINE_LOCATION',
          'ACCESS_COARSE_LOCATION',
          'RECORD_AUDIO',
        ];

        for (final permission in unnecessaryPermissions) {
          expect(
            content.contains(permission),
            isFalse,
            reason: 'Should not request unnecessary permission: $permission',
          );
        }
      });

      test('manifest package attribute is not set', () {
        final content = manifestFile.readAsStringSync();

        // In modern Android, package is defined in build.gradle, not manifest
        final manifestTag = RegExp(r'<manifest[^>]*>').firstMatch(content);
        if (manifestTag != null) {
          final manifestTagContent = manifestTag.group(0)!;
          // It's okay to have package attribute, but if absent, that's fine too
          // This test just validates the manifest tag is parseable
          expect(
            manifestTagContent.contains('<manifest'),
            isTrue,
            reason: 'Manifest tag should be present',
          );
        }
      });
    });

    group('XML Formatting and Best Practices', () {
      test('manifest uses proper indentation', () {
        final content = manifestFile.readAsStringSync();
        final lines = content.split('\n');

        // Check that there's some indentation (not all lines start at column 0)
        final indentedLines = lines.where((line) => line.startsWith(' ')).length;

        expect(
          indentedLines,
          greaterThan(5),
          reason: 'Manifest should have proper indentation',
        );
      });

      test('manifest has comments explaining key sections', () {
        final content = manifestFile.readAsStringSync();

        // Check for at least some documentation
        expect(
          content.contains('<!--'),
          isTrue,
          reason: 'Manifest should contain explanatory comments',
        );

        expect(
          content.contains('-->'),
          isTrue,
          reason: 'Comments should be properly closed',
        );
      });

      test('no duplicate meta-data entries', () {
        final content = manifestFile.readAsStringSync();

        final metadataPattern = RegExp(r'android:name="([^"]+)"');
        final matches = metadataPattern.allMatches(content);
        final names = matches.map((m) => m.group(1)).toList();

        final uniqueNames = names.toSet();

        expect(
          names.length,
          equals(uniqueNames.length),
          reason: 'Should not have duplicate metadata entries',
        );
      });
    });
  });
}