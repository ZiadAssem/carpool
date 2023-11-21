import 'package:carpool/reusable_widget.dart';
import 'package:flutter/material.dart';

import '../classes/ride.dart';
import 'trips_history.dart';

//dummy code
CampusRide ride = CampusRide(
    id: '1',
    source: 'MAADI',
    rider: 'Ahmed',
    numberOfSeats: 4,
    status: 'AVAILABLE');

//create a list of dummy rides
List<CampusRide> previousRides = [ride, ride, ride];

class CartPage extends StatelessWidget {
  const CartPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('Cart', null),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              _buildRideDetails(),
              const SizedBox(height: 16),
              _buildButton('Proceed to Payment', () {}),
              const SizedBox(height: 16),
              _buildButton('Trips History', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TripsHistory()));
              }),
              //  _buildPreviousTripsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideDetails() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From ${ride.source} to ${ride.destination}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildDetailRow('Rider:', ride.rider),
            _buildDetailRow(
                'Time:', ride.isMorningRide ? 'Morning' : 'Evening'),
            _buildDetailRow('Available Seats:', ride.numberOfSeats.toString()),
            _buildDetailRow('Status', 'Pending')
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildButton(text, Function() fnOnTap) {
    return ElevatedButton(
      onPressed: () {
        fnOnTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 142, 15, 6),
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        '$text',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
