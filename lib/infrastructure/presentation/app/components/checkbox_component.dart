import 'package:flutter/material.dart';

class CheckboxComponent extends StatefulWidget {
  const CheckboxComponent({super.key, required this.value, required this.label, required this.icon, required this.onChanged});
  final bool value;
  final String label;
  final IconData icon;
  final ValueChanged<bool?> onChanged;

  @override
  State<CheckboxComponent> createState() => _CheckboxComponentState();
}

class _CheckboxComponentState extends State<CheckboxComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CheckboxListTile(
      value: widget.value,
      onChanged: widget.onChanged,
      title: Row(
        children: [
          Icon(widget.icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
    );
  }
}