import 'package:flutter/material.dart';

class CodefireScaffold extends StatelessWidget {
  const CodefireScaffold({super.key, this.body, this.floatingActinButton, this.backgroundColor});
  final Widget? body;
  final Widget? floatingActinButton;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white12,
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1920,
            maxHeight: 1280,
          ),
          child: Stack(
            children: [
              Card(
                elevation: 10,
                color: backgroundColor ?? Colors.black,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: body,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.topRight,
                child: floatingActinButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CodefireGameComponents {
  static final codefireProgress = Container(
    width: double.maxFinite,
    height: double.maxFinite,
    color: Colors.transparent,
  );
}
