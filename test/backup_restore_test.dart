import 'package:flutter_test/flutter_test.dart';
import 'package:blackhole/Helpers/backup_restore.dart';

void main() {
  group('Backup Restore Core Tests', () {
    test('collectBoxNames flattens correctly', () {
      final items = ['user', 'settings'];

      final boxNameData = {
        'user': ['userBox', 'historyBox'],
        'settings': ['settingsBox'],
      };

      final result = collectBoxNames(items, boxNameData);

      expect(result, equals(['userBox', 'historyBox', 'settingsBox']));
    });

    test('collectBoxNames ignores missing keys safely', () {
      final items = ['user', 'missing'];

      final boxNameData = {
        'user': ['userBox'],
      };

      final result = collectBoxNames(items, boxNameData);

      expect(result, equals(['userBox']));
    });

    test('isSupportedBackupFile accepts zip', () {
      expect(isSupportedBackupFile('backup.zip'), isTrue);
    });

    test('isSupportedBackupFile accepts hive', () {
      expect(isSupportedBackupFile('data.hive'), isTrue);
    });

    test('isSupportedBackupFile rejects other extensions', () {
      expect(isSupportedBackupFile('file.txt'), isFalse);
      expect(isSupportedBackupFile('file.exe'), isFalse);
      expect(isSupportedBackupFile(''), isFalse);
    });
  });
}
