import 'package:codefire/decorations/button_blue.dart';

class Dungeon03Controller {
  Dungeon03Controller({required this.allButtons, required this.allButtonDecorations});

  final Set<int> _activatedButtons = {};
  final Set<int> allButtons;
  final Set<ButtonBlueDecoration> allButtonDecorations;

  bool allActivated() {
    return _activatedButtons.containsAll(allButtons);
  }

  void activate(int buttonId) {
    _activatedButtons.add(buttonId);
  }

  void deactivateAll() {
    for (var element in allButtonDecorations) {
      element.deactivate();
    }
    _activatedButtons.clear();
  }
}
