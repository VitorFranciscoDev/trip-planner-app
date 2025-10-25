import 'package:flutter/material.dart';
import 'package:trip_planner/entities/stop_recomendation.dart';

class RecomendationsListComponent extends StatefulWidget {
  const RecomendationsListComponent({ super.key, required this.stopRecomendations });
  final List<StopRecomendation> stopRecomendations;

  @override
  State<RecomendationsListComponent> createState() => _RecomendationsListComponentState();
}

class _RecomendationsListComponentState extends State<RecomendationsListComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      child: Container(
        width: 360,
        height: 220,
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: theme.colorScheme.primary),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  "Nordeste Brasileiro",
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.colorScheme.primary,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  "30 days",
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.colorScheme.primary,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.stopRecomendations.length,
                itemBuilder: (context, index) {
                  final location = widget.stopRecomendations[index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                location.img,
                                fit: BoxFit.cover,
                                width: 170,
                                height: 130,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_right, size: 30),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, right: 20),
                        child: Text(
                          location.name,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}