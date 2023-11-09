import 'dart:io';

import 'package:gtools/cmd/base_cmd.dart';
import 'package:gtools/utils/ext/file_ext.dart';
import 'package:gtools/utils/ext/string_ext.dart';
import 'package:yaml/yaml.dart';


class InfoCmd extends BaseCmd {

  const InfoCmd();

  @override
  String get cmd => 'info';

  @override
  String get help => '打印当前git的url等信息';

  @override
  Future<int> start(List<String> arguments) async {
    var result = await Process.run('git', ['remote', '-v'], runInShell: true);
    if(result.exitCode != 0) {
      print('${result.stderr}');
      return result.exitCode;
    }
    var branch = result.stdout.toString();
    if(branch.isEmpty) {
      print('没有关联remote');
      return -1;
    }
    final line = branch.firstLine;
    final url = line.substring(line.indexOf('git'), line.lastIndexOf('git') + 3);

    result = await Process.run('git', ['rev-parse', 'HEAD'], runInShell: true);
    final hash = result.stdout;

    Directory current = Directory.current;
    final entity = current.findFromParent((entity) => entity.name == 'pubspec.yaml');
    String? yamlPath = entity?.path;

    String? packageName;

    if(yamlPath != null) {
      // 读取YAML文件
      var file = File(yamlPath);
      var yamlString = file.readAsStringSync();

      // 解析YAML文件
      var yamlMap = loadYaml(yamlString);
      packageName = yamlMap['name'];
    }

    final text = '''
$packageName:
  git: 
    url: $url
    ref: $hash''';

    print(text);

    print('----------------');

    await text.toClipboard();

    return 0;
  }
}