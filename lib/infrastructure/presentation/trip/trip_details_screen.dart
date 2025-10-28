import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/alert_dialog_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/trip/pdf_register_screen.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({ super.key, required this.trip });
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
        onPressed: () => showDialog(
          context: context, 
          builder: (dialogContext) => AlertDialogComponent(
            title: "Wanna do a PDF of the Trip?",
            fn1: () => Navigator.of(context).pop(),
            fn1Message: "No", 
            fn2: () => Navigator.push(dialogContext, MaterialPageRoute(builder: (dialogContext) => PDFRegisterScreen(trip: widget.trip))), 
            fn2Message: "Yes",
          ),
        ),
        child: Icon(Icons.picture_as_pdf),
      ),
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 75),
              Text(
                widget.trip.title,
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Details",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ContainerTextFieldComponent(
                  height: 200,
                  child: Column(
                    children: [
                      Row(

                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Stops",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ContainerTextFieldComponent(
                  height: 250,
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
                                Icon(Icons.location_on, color: theme.colorScheme.primary, size: 18),
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
            ],
          ),
        ),
      ),
    );
  }
}