import 'dart:async';
import 'dart:io';

import 'package:gtools/gtools.dart';

const lineNumber = 'line-number';
const cTest = 'test';

Future<void> main(List<String> arguments) async {
  await GTools().start(arguments);
  exitCode = 0;
}
