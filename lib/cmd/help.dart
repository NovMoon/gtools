import 'dart:io';

import 'package:gtools/cmd/base_cmd.dart';
import 'package:gtools/gtools.dart';
import 'package:gtools/utils/ext/file_ext.dart';
import 'package:gtools/utils/ext/string_ext.dart';
import 'package:yaml/yaml.dart';


class HelpCmd extends BaseCmd {

  const HelpCmd();

  @override
  String get cmd => 'help';

  @override
  String get help => '打印帮助信息';

  @override
  Future<int> start(List<String> arguments) async {
    for (var e in GTools().cmdList) {
      var cmd = e.cmd;
      cmd += (20 - cmd.length).emptyStr;
      print('$cmd ${e.help}');
    }
    return 0;
  }
}