import 'package:gtools/gtools.dart';

abstract class BaseCmd with Runnable {
  const BaseCmd();

  String get cmd;

  String get help => '';
}
