import 'package:bonfire/bonfire.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/utilities/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/tomorrow.dart';

class CodefireField extends StatefulWidget {
  const CodefireField({
    super.key,
    required this.parentWidget,
    required this.codeController,
    required this.onPlay,
    required this.gameScreenFocus,
  });
  final Widget parentWidget;
  final CodeController codeController;
  final FocusNode gameScreenFocus;
  final ValueChanged<List<Map<String, dynamic>>> onPlay;

  static const codeTheme = tomorrowTheme;
  static const colorThemeName = 'title';
  static final patternMap = {
    'moveUp': TextStyle(color: codeTheme[colorThemeName]?.color),
    'moveDown': TextStyle(color: codeTheme[colorThemeName]?.color),
    'moveLeft': TextStyle(color: codeTheme[colorThemeName]?.color),
    'moveRight': TextStyle(color: codeTheme[colorThemeName]?.color),
  };

  @override
  State<CodefireField> createState() => _CodefireFieldState();
}

class _CodefireFieldState extends State<CodefireField> {
  List<Map<String, dynamic>> _commandList = [];
  String _commandListInStr = '';

  @override
  Widget build(BuildContext context) {
    final codeStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 18,
          fontFamily: 'NotoSansMono',
        );
    final consoleStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: 'NotoSansMono',
        );
    final codeField = CodeField(
      controller: widget.codeController,
      expands: true,
      textStyle: codeStyle,
      focusNode: FocusNode(),
    );
    final shortCutTextStyle = codeStyle.copyWith(fontWeight: FontWeight.bold);

    void insertCode(String code) {
      if (!codeField.focusNode!.hasFocus) {
        codeField.focusNode!.requestFocus();
        codeField.controller.selection =
            TextSelection.collapsed(offset: codeField.controller.text.length);
      }
      codeField.controller.insertStr(code);
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  child:
                      const SizedBox(height: 36, width: 64, child: Icon(Icons.arrow_back_rounded)),
                  onTap: () => insertCode('moveLeft(1);\n'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  child: const SizedBox(
                      height: 36, width: 64, child: Icon(Icons.arrow_upward_rounded)),
                  onTap: () => insertCode('moveUp(1);\n'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  child: const SizedBox(
                      height: 36, width: 64, child: Icon(Icons.arrow_downward_rounded)),
                  onTap: () => insertCode('moveDown(1);\n'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  child: const SizedBox(
                      height: 36, width: 64, child: Icon(Icons.arrow_forward_rounded)),
                  onTap: () => insertCode('moveRight(1);\n'),
                ),
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
                  onTap: () => insertCode('for (let idx = 1; idx <= 2; idx++) {}'),
                ),
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
                  onTap: () => insertCode('if (1 == 1) {}'),
                ),
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
                      child: const SizedBox(
                          height: 36, width: 64, child: Icon(Icons.fast_rewind_rounded)),
                      onTap: () {
                        final controller = BonfireInjector().get<NpcRoboDinoController>();
                        controller.initialize();
                        context.goTo(widget.parentWidget);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    child: const SizedBox(
                        height: 36, width: 64, child: Icon(Icons.play_arrow_rounded)),
                    onTapUp: (details) => widget.gameScreenFocus.requestFocus(),
                    onTap: () async {
                      widget.gameScreenFocus.requestFocus();
                      String code = widget.codeController.text;
                      final List<Map<String, dynamic>> playerCommandMap = code.toPlayerCommandMap();
                      try {
                        codeField.focusNode!.unfocus();
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
                      widget.onPlay(_commandList);
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
      ),
    );
  }
}
