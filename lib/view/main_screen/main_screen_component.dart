import 'package:codefire/utilities/extentions.dart';
import 'package:codefire/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class CordfireLevelCard extends StatelessWidget {
  const CordfireLevelCard({
    super.key,
    required this.name,
    required this.description,
    required this.map,
  });

  final String name;
  final String description;
  final Widget map;

  final TextStyle style = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.white12,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(name, style: style),
          ),
          onTap: () {
            context.goTo(map);
          },
        ),
      ),
    );
  }
}

class GoBackFloatingButton extends StatelessWidget {
  const GoBackFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.close_rounded),
      onPressed: () {
        context.goTo(const CodefireMainScreen());
      },
    );
  }
}
