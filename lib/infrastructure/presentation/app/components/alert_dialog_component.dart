import 'package:flutter/material.dart';

class AlertDialogComponent extends StatelessWidget {
  const AlertDialogComponent({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.fn1,
    this.fn1Message,
    required this.fn2,
    required this.fn2Message,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final VoidCallback? fn1;
  final String? fn1Message;
  final VoidCallback fn2;
  final String fn2Message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      content: message != null
          ? Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onBackground,
              ),
            )
          : null,
      actions: [
        if (fn1 != null)
          TextButton(
            onPressed: () => fn1!(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            child: Text(
              fn1Message!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ElevatedButton(
          onPressed: () => fn2(),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(
            fn2Message,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}