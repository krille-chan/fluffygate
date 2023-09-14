import '../src/init.dart';

void main(List<String> args) =>
    init(args.firstOrNull ?? '/etc/fluffygate/config.yaml');
