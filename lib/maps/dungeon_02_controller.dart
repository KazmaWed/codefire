class Dungeon02Controller {
  Dungeon02Controller({required this.allButtons});

  final Set<int> _activatedButtons = {};
  final Set<int> allButtons;

  bool allActivated() {
    return _activatedButtons.containsAll(allButtons);
  }

  void activate(int buttonId) {
    _activatedButtons.add(buttonId);
  }
}
