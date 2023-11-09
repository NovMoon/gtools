import 'package:gtools/cmd/base_cmd.dart';

import '../utils/file_util.dart';


class InstallAliasCmd extends BaseCmd {

  const InstallAliasCmd();

  @override
  String get cmd => 'install-alias';

  @override
  String get help => '在.bash_profile中安装命令别名，可使用-h查看具体内容';

  String get detailCmd => '''
# gtools

# 打印当前git的url等信息
alias ginfo='gtools info'

# 重置当前分支为远程分支
alias greset='gtools fetch-reset'

# 安装别名
alias galias='gtools install-alias'
    ''';

  @override
  Future<int> start(List<String> arguments) async {

    if(arguments.isNotEmpty && arguments[0] == '-h') {
      print('ginfo  打印当前git的url等信息');
      print('greset 重置当前分支为远程分支');
      print('galias 安装别名');
      return 0;
    }

    final home = Env.createHomeFile('.gtools');
    if(home == null) {
      return -1;
    }

    Env.addToBashProfile('''[[ -s "${home.path}" ]] && source "${home.path}" # Load the gtools file''');

    home.writeAsString(detailCmd);

    Env.addX(home.path);

    print(detailCmd);
    print('安装完成');
    return 0;
  }
}