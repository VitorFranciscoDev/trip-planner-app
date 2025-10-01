import 'package:flutter/material.dart';

class StopDialog extends StatefulWidget {
  const StopDialog({super.key});

  @override
  State<StopDialog> createState() => _StopDialogState();
}

class _StopDialogState extends State<StopDialog> {

  bool isCheckedCulture = false;
  bool isCheckedCulinaire = false;
  bool isCheckedHistoricLocals = false;
  bool isCheckedFranchise = false;
  bool isCheckedNature = false;

  Widget checkBox(bool checked, String text) {
    return Row(
      children: [
        Checkbox(
          value: checked, 
          onChanged: (newChecked) {
            setState(() {
              checked = newChecked!;
            });
          }
        ),
        Padding(padding: EdgeInsets.only(right: 3)),
        Text(text),
      ],
    );
  } 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFF8DC),
      content: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 50),
              child: const Text("Add Trip", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ),
            Row(
              children: [
                checkBox(isCheckedCulture, "Imersion in a Different Culture"),
                checkBox(isCheckedCulinaire, "Explore Alternative Culinaires"),
                checkBox(isCheckedHistoricLocals, "Visit Historic Locals"),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                checkBox(isCheckedFranchise, "Visit Local Franchises"),
                checkBox(isCheckedNature, "Contact with Nature"),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Add"),
        ),
      ],
    );
  }
}