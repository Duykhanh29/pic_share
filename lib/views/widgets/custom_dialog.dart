import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.actions,
    required this.content,
    super.key,
    this.isActionsRow = true,
    this.backgroundContentColor,
  });

  final String title;
  final List<Widget> actions;
  final bool isActionsRow;
  final Widget content;
  final Color? backgroundContentColor;

  @override
  Widget build(BuildContext context) => AlertDialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: backgroundContentColor ?? AppColors.white,
        contentPadding: const EdgeInsets.all(16),
        titlePadding: const EdgeInsets.all(16),
        actionsAlignment: MainAxisAlignment.start,
        title: Center(
          child: Text(
            title,
            // style: context.textTheme.titleLarge,
          ),
        ),
        actions: _buildActions(),
        actionsPadding: const EdgeInsets.all(16),
        content: SingleChildScrollView(
          child: content,
        ),
      );

  // Adjusted to return List<Widget>? and expand each action with spacing
  List<Widget>? _buildActions() {
    if (actions.isEmpty) {
      return null;
    }

    return [
      if (isActionsRow)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildExpandedActionsWithSpacing(),
        )
      else
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: actions,
        ),
    ];
  }

  // Method to expand each action and add horizontal space between them
  List<Widget> _buildExpandedActionsWithSpacing() {
    final List<Widget> spacedActions = [];

    for (int i = 0; i < actions.length; i++) {
      spacedActions.add(Expanded(child: actions[i]));

      // Add horizontalSpaceM between actions, but not after the last action
      if (i < actions.length - 1) {
        spacedActions.add(const SizedBox(width: 16));
      }
    }

    return spacedActions;
  }
}
