import 'package:carpool/reusable_widget.dart';
import 'package:carpool/view/cart.dart';
import 'package:flutter/material.dart';

import '../classes/ride.dart';
import '../classes_updated/trip_class.dart';
import '../firebase/database.dart';
import 'trip_details.dart';

class TripPage extends StatefulWidget {
  final List<List<Trip>> trips;
  final String location;
  TripPage({Key? key, required this.trips, required this.location});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Trip> _campusTrips;
  late List<Trip> _homeTrips;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _campusTrips = widget.trips[0];
    _homeTrips = widget.trips[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('Trips', _buildTabBar()),
      //backgroundColor: Colors.transparent,
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRideList(_campusTrips, false),
          _buildRideList(_homeTrips, true),
        ],
      ),
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

  Widget _buildRideList(rides, bool isHomeRide) {
    if (rides.length == 0) {
      return Center(
          child: Text(
        "No rides available",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: reusableColor()),
      ));
    }
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: isHomeRide
                ? _buildRide(rides, index, true)
                : _buildRide(rides, index, false));
      },
    );
  }

  Widget _buildRide(rides, index, isHomeRide) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      color: const Color.fromARGB(
          255, 255, 255, 255), // Card background color (white)
      child: ListTile(
        title: Text(
          widget.location,
          style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: reusableColor()), // Adjust text color
        ),
        subtitle: Text(
          'Driver: ${rides[index].driver}',
          style:  TextStyle(
              color: reusableColor()), // Adjust text color
        ),
        leading:  Icon(
          Icons.bus_alert_rounded,
          color: reusableColor(), // Adjust icon color
        ),
        trailing: isHomeRide
            ? _buildHomeRide(rides, index)
            : _buildCampusRide(rides, index),
        onTap: () {
          print(rides);
          print(rides[index]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripDetails(
                  trip: rides[index],
                  location: widget.location,
                  isHomeRide: isHomeRide),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCampusRide(rides, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Seats Left: ${rides[index].numberOfSeatsLeft}",
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
