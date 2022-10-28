import 'dart:io';

import 'package:dart_eval/dart_eval.dart';

String comp(String code) {
  final compiler = Compiler();
  final program = compiler.compile({
    'example': {'main.dart': code}
  });
  final bytecode = program.write().buffer.asByteData();
  final runtime = Runtime(bytecode);
  runtime.setup();
  return runtime.executeLib('package:example/main.dart', 'main').toString();
}

String execute() {
  final file = File('program.evc');
  final bytecode = file.readAsBytesSync().buffer.asByteData();

  final runtime = Runtime(bytecode);
  runtime.setup();
  return runtime.executeLib('package:example/main.dart', 'main').toString();
}
