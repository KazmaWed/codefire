import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/dart.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static String initialValue = '''
int n = 1;
int m = 10;
int result = n;
for(var idx = n; idx <= m; idx++) {
  result *= idx;
}
return result.runtimeType;
''';

  final controller = CodeController(
    text: initialValue,
    language: dart,
    theme: atomOneLightTheme,
    onChange: (value) {},
  );
  final style = const TextStyle(fontSize: 21);

  String result = '';

  // String execute(String code) {
  //   final compiler = Compiler();

  //   final program = compiler.compile({
  //     'my_package': {'main.dart': code}
  //   });

  //   final bytecode = program.write();

  //   final file = File('program.evc');
  //   file.writeAsBytesSync(bytecode);

  //   // final _file = File('program.evc');
  //   final _bytecode = file.readAsBytesSync().buffer.asByteData();

  //   final runtime = Runtime(_bytecode);
  //   runtime.setup();
  //   return runtime.executeLib('package:my_package/main.dart', 'main').toString();
  // }

  @override
  Widget build(BuildContext context) {
    final codeField = CodeField(
      controller: controller,
      expands: true,
      textStyle: style,
    );

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    result == '' ? 'null' : result,
                    style: style,
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(child: codeField),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          child: Text(
                            'EXECUTE',
                            style: style,
                          ),
                          onPressed: () {
                            final fixed = controller.text.replaceAll('·', ' ');
                            try {
                              setState(() => result = eval(fixed).toString());
                            } catch (e) {
                              setState(() => result = e.toString());
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
