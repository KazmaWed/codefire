// import 'dart:io';
// import 'package:dart_eval/dart_eval.dart';

// void compile(String code) {
//   final compiler = Compiler();

//   final program = compiler.compile({
//     'my_package': {'main.dart': code}
//   });

//   final bytecode = program.write();

//   final file = File('program.evc');
//   file.writeAsBytesSync(bytecode);

//   final bytedata = file.readAsBytesSync().buffer.asByteData();

//   final runtime = Runtime(bytedata);
//   runtime.setup();
// }
