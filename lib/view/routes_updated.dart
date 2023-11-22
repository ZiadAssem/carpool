import 'package:carpool/classes/ride.dart';
import 'package:carpool/classes_updated/routes_class.dart';
import 'package:flutter/material.dart';

import '../reusable_widget.dart';

class RoutesUpdated extends StatefulWidget {
  const RoutesUpdated({super.key});

  @override
  State<RoutesUpdated> createState() => _RoutesUpdatedState();
}

class _RoutesUpdatedState extends State<RoutesUpdated>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('RoutesUpdated', null),
      //backgroundColor: Colors.transparent,
      body: _buildRoutesList(),
    );
  }

  Widget _buildRoutesList() {
    return ListView.builder(
      itemCount: routesLocations.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: _buildRoute(routesLocations, index),
        );
      },
    );
  }

  Widget _buildRoute(routesLocations, int index) {
    final route = routesLocations[index];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          route.location,
          style: TextStyle(
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
        trailing: Icon(
          Icons.arrow_forward,
          color: Color.fromARGB(255, 142, 15, 6),
        ),
        onTap: () {
          // Handle tap
        },
      ),
    );
  }

  Widget _buildTabBarView(CampusRides, HomeRides) {
    return TabBarView(
      controller: _tabController,
      children: [
        // _buildRideList(CampusRides, false),
        // _buildRideList(HomeRides, true),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      controller: _tabController,
      tabs: const <Widget>[
        Tab(icon: Icon(Icons.directions_bus_rounded), text: "Campus Rides"),
        Tab(icon: Icon(Icons.home_rounded), text: "Home Rides"),
      ],
    );
  }

  Widget _buildCampusRide(rides, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Seats Left: ${rides[index].numberOfSeats}",
          style: const TextStyle(color: Colors.black), // Adjust text color
        ),
        const SizedBox(height: 4),
        const Text(
          "7:30",
          style: TextStyle(color: Colors.black), // Adjust text color
        ),
        const SizedBox(height: 4),
        isBefore10PM()
            ? Text(
                "${getTomorrowDate()}",
                style:
                    const TextStyle(color: Colors.black), // Adjust text color
              )
            : Text(
                "${getAfterTomorrowDate()}",
                style:
                    const TextStyle(color: Colors.black), // Adjust text color
              ),
      ],
    );
  }

  Widget _buildHomeRide(rides, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Seats Left: ${rides[index].numberOfSeats}",
          style: const TextStyle(color: Colors.black), // Adjust text color
        ),
        const SizedBox(height: 4),
        const Text(
          "5:30",
          style: TextStyle(color: Colors.black), // Adjust text color
        ),
        const SizedBox(height: 4),
        isBefore1PM()
            ? Text(
                "${getTodayDate()}",
                style:
                    const TextStyle(color: Colors.black), // Adjust text color
              )
            : Text(
                "${getTomorrowDate()}",
                style:
                    const TextStyle(color: Colors.black), // Adjust text color
              )
      ],
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
