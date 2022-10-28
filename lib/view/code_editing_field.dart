import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/dart.dart';

class CodeEditorField extends StatefulWidget {
  const CodeEditorField({super.key});

  @override
  State<CodeEditorField> createState() => _CodeEditorFieldState();
}

class _CodeEditorFieldState extends State<CodeEditorField> {
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();
    const source = "void main() {\n    print(\"Hello, world!\");\n}";
    _codeController = CodeController(
      text: source,
      language: dart,
      theme: atomOneLightTheme,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CodeField(
        controller: _codeController!,
        textStyle: const TextStyle(fontFamily: 'NotoSansMono'),
      ),
    );
  }
}
