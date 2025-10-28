import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/trip/stop_details_screen.dart';

class PDFRegisterScreen extends StatefulWidget {
  const PDFRegisterScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<PDFRegisterScreen> createState() => _PDFRegisterScreenState();
}

class _PDFRegisterScreenState extends State<PDFRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                "PDF Register",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Experiences in Stops",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontFamily: "Times New Roman",
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ContainerTextFieldComponent(
                  height: 550,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: widget.trip.stops!.length,
                    itemBuilder: (context, index) {
                      final stop = widget.trip.stops![index];
                      return Padding(
                        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StopDetailsScreen())),
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
                                  Spacer(),
                                  Icon(Icons.arrow_right, color: theme.colorScheme.primary),
                                  const SizedBox(width: 15),
                                ],
                              ),
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