import 'package:gtools/cmd/fetch_reset.dart';
import 'package:gtools/cmd/info.dart';
import 'package:gtools/cmd/install_alias.dart';

import 'cmd/base_cmd.dart';
import 'cmd/help.dart';

class GTools with Runnable {
  factory GTools() => _instance;

  GTools._();

  static final GTools _instance = GTools._();

  final List<BaseCmd> cmdList = [
    FetchResetCmd(),
    InfoCmd(),
    InstallAliasCmd(),
    HelpCmd(),
  ];

  @override
  Future<int> start(List<String> arguments) async {
    arguments = [...arguments];
    final cmd = arguments.removeAt(0);

    BaseCmd? target;

    for (var c in cmdList) {
      if (c.cmd == cmd) {
        target = c;
        break;
      }
    }
    if (target != null) {
      target.start(arguments);
      return 0;
    }
    print('未找到命令：$cmd');
    return -1;
  }
}

mixin Runnable {
  Future<int> start(List<String> arguments);
}
