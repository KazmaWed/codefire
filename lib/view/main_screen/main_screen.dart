import 'package:codefire/view/main_screen/command_generater.dart';
import 'package:codefire/view/main_screen/compiler.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/dart.dart';
import 'operation_methods.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static String initialValue = sampleCode;

  final controller = CodeController(
    text: initialValue,
    language: dart,
    theme: atomOneLightTheme,
    onChange: (value) {},
  );
  final style = const TextStyle(fontSize: 21);

  String result = '';

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
                    result == '' ? 'no output...' : result,
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
                            String fixed = spaceFix(controller.text);
                            fixed = spacifyAll(fixed);
                            fixed = multiplize(fixed);
                            fixed = moveupify(fixed);
                            fixed = generateCommand(fixed);
                            print(fixed);
                            try {
                              // setState(() => result = eval(fixed).toString());
                              final executed = comp(fixed);
                              setState(() {
                                result = executed;
                              });
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
