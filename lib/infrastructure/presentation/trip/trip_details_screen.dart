import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/alert_dialog_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/pdf_register_screen.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stops = widget.trip.stops;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.trip.concluded) {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialogComponent(
                title: "Wanna do a Booklet of the Trip?",
                fn1: () => Navigator.of(context).pop(),
                fn1Message: "No",
                fn2: () => Navigator.push(
                  dialogContext,
                  MaterialPageRoute(
                    builder: (dialogContext) =>
                        PDFRegisterScreen(trip: widget.trip),
                  ),
                ),
                fn2Message: "Yes",
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialogComponent(
                title: "Want to Edit the Trip?",
                fn1: () => Navigator.of(context).pop(),
                fn1Message: "No",
                fn2: () {
                  context.read<TripProvider>().trip = widget.trip;
                  Navigator.of(dialogContext).pop();
                  Navigator.pop(context);
                  context.read<BottomNavigatorProvider>().setIndex(1);
                },
                fn2Message: "Yes",
              ),
            );
          }
        },
        child: widget.trip.concluded
            ? Icon(Icons.library_books)
            : Icon(Icons.edit),
      ),
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "- Details",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ContainerTextFieldComponent(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Name: ${widget.trip.title}",
                        style: TextStyle(
                          color: Color(0xFF8B4513),
                          fontFamily: "Times New Roman",
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Transport: ${widget.trip.transport}",
                        style: TextStyle(
                          color: Color(0xFF8B4513),
                          fontFamily: "Times New Roman",
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Start Date: ${widget.trip.start_date}",
                        style: TextStyle(
                          color: Color(0xFF8B4513),
                          fontFamily: "Times New Roman",
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "End Date: ${widget.trip.end_date}",
                        style: TextStyle(
                          color: Color(0xFF8B4513),
                          fontFamily: "Times New Roman",
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "- Group",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ContainerTextFieldComponent(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: widget.trip.group!.length,
                  itemBuilder: (context, index) {
                    final person = widget.trip.group![index];
                    return Padding(
                      padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            Icon(
                              Icons.person,
                              color: theme.colorScheme.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              person.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "- Stops",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ContainerTextFieldComponent(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: stops!.length,
                  itemBuilder: (context, index) {
                    final stop = stops[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            Icon(
                              Icons.location_on,
                              color: theme.colorScheme.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              stop.location,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
