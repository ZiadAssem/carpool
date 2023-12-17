import 'package:carpool/firebase/database.dart';
import 'package:carpool/view/trips.dart';
import 'package:flutter/material.dart';
import '../classes_updated/routes_class.dart' as R;

import '../reusable_widget.dart';

class RoutesUpdated extends StatefulWidget {
  const RoutesUpdated({super.key});

  @override
  State<RoutesUpdated> createState() => _RoutesUpdatedState();
}

class _RoutesUpdatedState extends State<RoutesUpdated> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('RoutesUpdated', null),
      backgroundColor: Colors.transparent,
      body: _buildRoutesListFromDb(),
    );
  }

  Widget _buildRoutesListFromDb() {
    return FutureBuilder<List<R.Route>>(
      future: DatabaseHelper.instance.getRoutesFromDb(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          List<R.Route> routes = snapshot.data!;

          print(routes.length);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _buildRoutesList(routes),
          );
        } else if (snapshot.hasError) {
          return Text(" ${snapshot.error}");
        }
        return Text("No data");
      },
    );
  }

  Widget _buildRoutesList(databaseRoutes) {
    return ListView.builder(
      itemCount: databaseRoutes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: _buildRoute(databaseRoutes, index),
        );
      },
    );
  }

  Widget _buildRoute(databaseRoutes, int index) {
    final route = databaseRoutes[index];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          route.location,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 142, 15, 6),
          ),
        ),
        subtitle: Text(
          'Tap to view details',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Color.fromARGB(255, 142, 15, 6),
        ),
        onTap: () async {
          final trips =
              await DatabaseHelper.instance.getTripsFromDb(route.location);

              print('Trips tessssssssssst $trips');
          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TripPage(trips: trips, location: route.location),
            ),
          );
        },
      ),
    );
  }

  bool isBefore1PM() {
    DateTime now = DateTime.now();
    DateTime onePM = DateTime(now.year, now.month, now.day, 13, 0, 0);

    return now.isBefore(onePM);
  }

  bool isBefore10PM() {
    DateTime now = DateTime.now();
    DateTime tenPM = DateTime(now.year, now.month, now.day, 22, 0, 0);

    return now.isBefore(tenPM);
  }

  String getTodayDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${_addLeadingZero(now.month)}-${_addLeadingZero(now.day)}";

    return formattedDate;
  }

  String getTomorrowDate() {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    String formattedDate =
        "${tomorrow.year}-${_addLeadingZero(tomorrow.month)}-${_addLeadingZero(tomorrow.day)}";

    return formattedDate;
  }

  String getAfterTomorrowDate() {
    DateTime now = DateTime.now();
    DateTime afterTomorrow = now.add(const Duration(days: 2));
    String formattedDate =
        "${afterTomorrow.year}-${_addLeadingZero(afterTomorrow.month)}-${_addLeadingZero(afterTomorrow.day)}";

    return formattedDate;
  }

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }
}
