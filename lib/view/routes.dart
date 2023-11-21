import 'package:carpool/reusable_widget.dart';
import 'package:flutter/material.dart';

import '../classes/ride.dart';
import 'trip_details.dart';

CampusRide campusRide1 = CampusRide(
  id: '1',
  source: 'MAADI',
  rider: 'Ahmed',
  numberOfSeats: 4,
    status:  'AVAILABLE'

);

CampusRide campusRide2 = CampusRide(
  id: '2',
  source: 'NEWCAIRO',
  rider: 'Ahmed',
  numberOfSeats: 2,
    status:  'AVAILABLE'

);

CampusRide campusRide3 = CampusRide(
  id: '3',
  source: 'HELIOPLIS',
  rider: 'Ahmed',
  numberOfSeats: 3,
    status:  'AVAILABLE'

);

HomeRide homeRide1 = HomeRide(
  id: '4',
  destination: 'Maadi',
  rider: 'Ahmed',
  numberOfSeats: 1,
  status:  'AVAILABLE'
);

List<CampusRide> CampusRides = [campusRide1, campusRide2, campusRide3];
List<HomeRide> HomeRides = [homeRide1];

class Routes extends StatefulWidget {
  const Routes({Key? key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar(
        'Routes',
        TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.directions_bus_rounded),
              text: "Campus Rides",
            ),
            Tab(
              icon: Icon(Icons.home_rounded),
              text: "Home Rides",
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRideList(CampusRides, false),
          _buildRideList(HomeRides, true),
        ],
      ),
    );
  }

  Widget _buildRideList(List<Ride> rides, bool isHomeRide) {
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            color: const Color.fromARGB(
                255, 255, 255, 255), // Card background color (white)
            child: ListTile(
              title: Text(
                rides[index].source,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(
                        255, 142, 15, 6)), // Adjust text color
              ),
              subtitle: Text(
                'Driver: ${rides[index].rider}',
                style: const TextStyle(
                    color: Color.fromARGB(
                        255, 142, 15, 6)), // Adjust text color
              ),
              leading: const Icon(
                Icons.bus_alert_rounded,
                color:
                    Color.fromARGB(255, 142, 15, 6), // Adjust icon color
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seats Left: ${rides[index].numberOfSeats}",
                    style: const TextStyle(color: Colors.black), // Adjust text color
                  ),
                  const SizedBox(height: 4),
                  isHomeRide? Text(
                    "5:30",
                    style: TextStyle(color: Colors.black), // Adjust text color
                  ):Text(
                    "7:30",
                    style: TextStyle(color: Colors.black), // Adjust text color
                  ),
                  const SizedBox(height: 4),
                  if (isHomeRide)
                    isBefore10PM()
                        ? Text(
                            "${getTodayDate()}",
                            style: const TextStyle(
                                color: Colors.black), // Adjust text color
                          )
                        : Text(
                            "${getTomorrowDate()}",
                            style: const TextStyle(
                                color: Colors.black), // Adjust text color
                          )
                  else
                    isBefore10PM()
                        ? Text(
                            "${getTodayDate()}",
                            style: const TextStyle(
                                color: Colors.black), // Adjust text color
                          )
                        : Text(
                            "${getTomorrowDate()}",
                            style: const TextStyle(
                                color: Colors.black), // Adjust text color
                          ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetails(
                      ride: rides[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
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

  String _addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }
}
