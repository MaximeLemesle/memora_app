import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Flutter version should be 3.27.2', () async {
    // Run the flutter command to get the version
    final result = await Process.run(
      'flutter',
      ['--version', '--machine'],
      runInShell: true,
    );
    final json = jsonDecode(result.stdout);
    final version = json['frameworkVersion'];

    expect(version, equals('3.27.2'));
  });
}
