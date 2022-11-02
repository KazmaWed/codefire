import 'package:codefire/utilities/extentions.dart';
import 'package:codefire/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class CordfireLevelCard extends StatelessWidget {
  const CordfireLevelCard({
    super.key,
    required this.context,
    required this.name,
    required this.description,
    required this.map,
  });

  final BuildContext context;
  final String name;
  final String description;
  final Widget map;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
        Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white);
    final TextStyle descriptionStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white);

    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white12,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            Text(name, style: titleStyle),
            const SizedBox(height: 8),
            Text(
              description,
              style: descriptionStyle,
            )
          ]),
        ),
        onTap: () {
          context.goTo(map);
        },
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
