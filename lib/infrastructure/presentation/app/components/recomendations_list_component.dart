import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';

class RecomendationsListComponent extends StatefulWidget {
  const RecomendationsListComponent({ super.key, required this.tripRecomendation, required this.fn });
  final Trip tripRecomendation;
  final VoidCallback fn;

  @override
  State<RecomendationsListComponent> createState() => _RecomendationsListComponentState();
}

class _RecomendationsListComponentState extends State<RecomendationsListComponent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => widget.fn(),
      child: Container(
        width: 360,
        height: 250,
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
                  widget.tripRecomendation.title,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.primary,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  widget.tripRecomendation.transport,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.primary,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  "${widget.tripRecomendation.start_date} - ${widget.tripRecomendation.end_date}",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.primary,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.tripRecomendation.stops!.length,
                itemBuilder: (context, index) {
                  final stop = widget.tripRecomendation.stops![index];
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                stop.img!,
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
                          stop.location,
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