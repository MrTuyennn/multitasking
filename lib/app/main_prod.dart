import 'package:multitasking/app/config/app_config.dart';
import 'package:multitasking/app/config/evn.dart';
import 'package:multitasking/main.dart' as common;

void main() async {
  final config = await AppConfigProvider.loadConfig(
    Environment.PRODUCTION.name,
  );
  common.main(config);
}
