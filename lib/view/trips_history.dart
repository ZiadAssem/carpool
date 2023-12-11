import 'package:carpool/classes/ride.dart';
import 'package:carpool/classes_updated/triprequest_class.dart';
import 'package:carpool/firebase/authentication.dart';
import 'package:carpool/firebase/database.dart';
import 'package:carpool/reusable_widget.dart';
import 'package:flutter/material.dart';



class TripsHistory extends StatelessWidget {
  const TripsHistory({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('History', null),
      body: _getPreviousTrips(),
    );
  }

  Widget _getPreviousTrips() {
    return FutureBuilder(
        future: DatabaseHelper.instance
            .getPreviousTrips(Authentication.instance.currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final trips = snapshot.data as List<TripRequest>;
            return _buildRequestList(trips);
          } else if (snapshot.hasError) {
            return Text("NO DATA");
          }
          return Text("No data");
        });
  }

  Widget _buildRequestList(trips) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _buildRideDetails(trips, index);
      },
    );
    ;
  }

  Widget _buildRideDetails(trips, index) {
    return ListTile(
      leading: _buildStatusIcon(trips[index].status),
      title: Text('Trip ${index + 1}'),
      subtitle: Text(trips[index].pickup + ' to ' + trips[index].destination),
      onTap: () {},
    );
  }

  Icon _buildStatusIcon(String status) {
    // Customize the icon based on the status
    IconData iconData;
    Color iconColor;

    switch (status) {
      case 'completed':
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
