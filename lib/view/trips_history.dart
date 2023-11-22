import 'package:carpool/classes/ride.dart';
import 'package:carpool/reusable_widget.dart';
import 'package:flutter/material.dart';

CampusRide ride1 = CampusRide(
  id: '1',
  source: 'MAADI',
  rider: 'Ahmed',
  numberOfSeats: 4,
      price: 30,

  status: 'COMPLETE',
);
CampusRide ride2 = CampusRide(
  id: '2',
  source: 'NEWCAIRO',
  rider: 'Ahmed',
  numberOfSeats: 2,
      price: 30,

  status: 'COMPLETE',
);
CampusRide ride3 = CampusRide(
  id: '3',
  source: 'HELIOPLIS',
  rider: 'Ahmed',
  numberOfSeats: 3,
      price: 30,

  status: 'COMPLETE',
);
CampusRide ride4 = CampusRide(
  id: '4',
  source: 'DOWNTOWN',
  rider: 'Ahmed',
  numberOfSeats: 1,
      price: 30,

  status: 'COMPLETE',
);
List<Ride> previousRides = [ride1, ride2, ride3, ride4];

class TripsHistory extends StatelessWidget {
  const TripsHistory({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('History', null),
      body: ListView.builder(
        itemCount: previousRides.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: _buildStatusIcon(previousRides[index].status),
            title: Text('Trip ${index + 1}'),
            subtitle: Text(previousRides[index].source),
            onTap: () {
            },
          );
        },
      ),
    );
  }

  Icon _buildStatusIcon(String status) {
    // Customize the icon based on the status
    IconData iconData;
    Color iconColor;

    switch (status) {
      case 'COMPLETE':
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        break;
      // Add more cases for other statuses
      default:
        iconData = Icons.info;
        iconColor = Colors.grey;
    }

    return Icon(
      iconData,
      color: iconColor,
    );
  }
}
