import 'package:gtools/cmd/base_cmd.dart';
import 'package:gtools/utils/ext/string_ext.dart';
import 'package:gtools/utils/tips.dart';


class FetchResetCmd extends BaseCmd {

  const FetchResetCmd();

  @override
  String get cmd => 'fetch-reset';

  @override
  String get help => '重置当前分支为远程分支，一般用于别人rebase了分支';

  @override
  Future<int> start(List<String> arguments) async {

    var result = await 'git fetch --all'.runAsCmd();
    if(result.isNull) {
      return -1;
    }

    var branch = await 'git branch --show-current'.runAsCmd();
    if(branch.beEmptyOrNull) {
      return -1;
    }
    branch = 'origin/$branch';

    final yn = yOrN('将使用 远程分支覆盖本地内容');
    if(yn) {
      return -1;
    }

    result = await 'git reset --hard $branch'.runAsCmd();
    if(result.isNull) {
      return -1;
    }
    print('已重置当前代码为远程分支');
    return 0;
  }
}