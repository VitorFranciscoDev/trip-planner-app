import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_details_screen.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
import 'package:trip_planner/entities/trip.dart';

class ListTripsScreen extends StatefulWidget {
  const ListTripsScreen({super.key});

  @override
  State<ListTripsScreen> createState() => _ListTripsScreenState();
}

class _ListTripsScreenState extends State<ListTripsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = context.read<AuthProvider>().user;
      if (user != null) {
        context.read<TripProvider>().getAllTrips(user.id);
      }
    });
  }

  // Função para verificar se a viagem já passou da data de término
  bool _isTripExpired(String endDate) {
    try {
      final dateParts = endDate.split('/');
      if (dateParts.length != 3) return false;

      final day = int.tryParse(dateParts[0]);
      final month = int.tryParse(dateParts[1]);
      final year = int.tryParse(dateParts[2]);

      if (day == null || month == null || year == null) return false;

      final tripEndDate = DateTime(year, month, day);
      final today = DateTime.now();
      
      // Compara apenas a data, ignorando a hora
      final todayDate = DateTime(today.year, today.month, today.day);
      
      return todayDate.isAfter(tripEndDate);
    } catch (e) {
      return false;
    }
  }

  Future<void> _showConcludeDialog(Trip trip) async {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: theme.colorScheme.primary, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Conclude Trip",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The trip \"${trip.title}\" has ended on ${trip.end_date}.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Text(
              "Would you like to mark it as concluded?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
            ),
            child: const Text("Not Now", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              
              final provider = context.read<TripProvider>();
              final updatedTrip = Trip(
                id: trip.id,
                user_id: trip.user_id,
                title: trip.title,
                transport: trip.transport,
                start_date: trip.start_date,
                end_date: trip.end_date,
                concluded: true,
                group: trip.group,
                stops: trip.stops,
              );

              final result = await provider.updateTrip(updatedTrip);

              if (result == null) {
                final user = context.read<AuthProvider>().user;
                if (user != null) {
                  await provider.getAllTrips(user.id);
                }

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Trip marked as concluded!"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } else {
                // Erro
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Mark as Concluded", style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    final trips = context.watch<TripProvider>().trips;
    final activeTrips = trips.where((trip) => !trip.concluded).toList();
    final concludedTrips = trips.where((trip) => trip.concluded).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(intl.yourTrips, 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(intl.activeTrips, 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: activeTrips.length,
                itemBuilder: (context, index) {
                  final activeTrip = activeTrips[index];
                  final isExpired = _isTripExpired(activeTrip.end_date);
                  
                  return Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => TripDetailsScreen(trip: activeTrip))
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: isExpired 
                              ? Colors.orange 
                              : theme.colorScheme.primary,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 15),
                                Icon(
                                  Icons.airplanemode_active, 
                                  color: isExpired 
                                    ? Colors.orange 
                                    : theme.colorScheme.primary, 
                                  size: 18
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    activeTrip.title, 
                                    style: TextStyle(
                                      color: isExpired 
                                        ? Colors.orange 
                                        : theme.colorScheme.primary,
                                      fontFamily: "Times New Roman",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                if (isExpired) ...[
                                  IconButton(
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: Colors.orange,
                                      size: 24,
                                    ),
                                    onPressed: () => _showConcludeDialog(activeTrip),
                                    tooltip: "Mark as concluded",
                                  ),
                                ] else
                                  const SizedBox(width: 15),
                              ],
                            ),
                            if (isExpired)
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Ended",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(intl.concludedTrips, 
              style: TextStyle(
                color: Color(0xFF8B4513),
                fontFamily: "Times New Roman",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ContainerTextFieldComponent(
              height: 220,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: concludedTrips.length,
                itemBuilder: (context, index) {
                  final concludedTrip = concludedTrips[index];
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
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              concludedTrip.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text(
                              "${concludedTrip.start_date} - ${concludedTrip.end_date}",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Times New Roman",
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
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
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}