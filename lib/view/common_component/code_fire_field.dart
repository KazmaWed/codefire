import 'package:bonfire/bonfire.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:codefire/maps/dungeon_01.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/utilities/extentions.dart';
import 'package:flutter/material.dart';

class CodeFireField extends StatefulWidget {
  const CodeFireField({
    super.key,
    required this.parentWidget,
    required this.controller,
    required this.callback,
  });
  final Widget parentWidget;
  final CodeController controller;
  final ValueChanged<List<String>> callback;

  @override
  State<CodeFireField> createState() => _CodeFireFieldState();
}

class _CodeFireFieldState extends State<CodeFireField> {
  List<String> _result = [];

  @override
  Widget build(BuildContext context) {
    final codeStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18);
    final consoleStyle = Theme.of(context).textTheme.bodyMedium!;
    final codeField = CodeField(
      controller: widget.controller,
      expands: true,
      textStyle: codeStyle,
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(child: codeField),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        _result.isEmpty ? 'no command' : _result.toString(),
                        style: consoleStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                    child: const SizedBox(height: 64, width: 64, child: Icon(Icons.replay)),
                    onTap: () {
                      final controller = BonfireInjector().get<NpcRoboDinoController>();
                      controller.initialize();
                      context.goTo(widget.parentWidget);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  child: const SizedBox(height: 64, width: 64, child: Icon(Icons.play_arrow)),
                  onTap: () async {
                    String code = widget.controller.text;
                    try {
                      setState(() => _result = code.toPlayerCommand());
                    } catch (error) {
                      setState(() => _result = [error.toString()]);
                    }
                    widget.callback(_result);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
