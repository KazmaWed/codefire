import 'package:bonfire/bonfire.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/utilities/extentions.dart';
import 'package:flutter/material.dart';

class CodeFireField extends StatefulWidget {
  const CodeFireField({
    super.key,
    required this.parentWidget,
    required this.controller,
    required this.callback,
    required this.gameScreenFocus,
  });
  final Widget parentWidget;
  final CodeController controller;
  final ValueChanged<List<Map<String, dynamic>>> callback;
  final FocusNode gameScreenFocus;

  @override
  State<CodeFireField> createState() => _CodeFireFieldState();
}

class _CodeFireFieldState extends State<CodeFireField> {
  List<Map<String, dynamic>> _commandList = [];
  String _commandListInStr = '';
  final _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final codeStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18);
    final consoleStyle = Theme.of(context).textTheme.bodyMedium!;
    final codeField = CodeField(
      controller: widget.controller,
      expands: true,
      textStyle: codeStyle,
      focusNode: _focus,
    );
    final shortCutTextStyle = codeStyle;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                  child:
                      const SizedBox(height: 36, width: 64, child: Icon(Icons.arrow_back_rounded)),
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                  child: const SizedBox(
                      height: 36, width: 64, child: Icon(Icons.arrow_upward_rounded)),
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                  child: const SizedBox(
                      height: 36, width: 64, child: Icon(Icons.arrow_downward_rounded)),
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                  child: const SizedBox(
                      height: 36, width: 64, child: Icon(Icons.arrow_forward_rounded)),
                  onTap: () {}),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 36,
                    width: 64,
                    child: Text('FOR', style: shortCutTextStyle),
                  ),
                  onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 36,
                    width: 64,
                    child: Text('IF', style: shortCutTextStyle),
                  ),
                  onTap: () {}),
            ),
          ]),
          const Divider(),
          Expanded(child: codeField),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                    child: const SizedBox(height: 36, width: 64, child: Icon(Icons.replay_rounded)),
                    onTap: () {
                      final controller = BonfireInjector().get<NpcRoboDinoController>();
                      controller.initialize();
                      context.goTo(widget.parentWidget);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  child:
                      const SizedBox(height: 36, width: 64, child: Icon(Icons.play_arrow_rounded)),
                  onTapUp: (details) => widget.gameScreenFocus.requestFocus(),
                  onTap: () async {
                    widget.gameScreenFocus.requestFocus();
                    String code = widget.controller.text;
                    final List<Map<String, dynamic>> playerCommandMap = code.toPlayerCommandMap();
                    try {
                      _focus.unfocus();
                      _commandList = playerCommandMap;
                      setState(() {
                        _commandListInStr = playerCommandMap.toString();
                      });
                    } catch (error) {
                      _commandList = [];
                      setState(() {
                        _commandListInStr = error.toString();
                      });
                    }
                    widget.callback(_commandList);
                  },
                ),
              ),
            ],
          ),
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
                          _commandListInStr,
                          style: consoleStyle,
                          minLines: 5,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
