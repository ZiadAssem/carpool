import 'package:carpool/classes_updated/triprequest_class.dart';
import 'package:carpool/firebase/authentication.dart';
import 'package:carpool/firebase/database.dart';
import 'package:carpool/reusable_widget.dart';
import 'package:flutter/material.dart';

import '../classes/ride.dart';
import 'trips_history.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                _buildTripList(),
                const SizedBox(height: 16),
                _buildButton('Trips History', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TripsHistory()));
                }),
                //  _buildPreviousTripsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripList() {
    return FutureBuilder(
        future: DatabaseHelper.instance
            .getAcceptedTripData(Authentication.instance.currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<TripRequest> tripRequests = snapshot.data as List<TripRequest>;

            if (tripRequests.isEmpty) {
              return const Text(
                "No trips in your cart",
                style: TextStyle(fontSize: 40),
              );
            }
            return _buildRequestList(tripRequests);
          } else if (snapshot.hasError) {
            return const Text(
              "Error",
              style: TextStyle(fontSize: 45),
            );
          }
          return const Text(
            "Weird",
            style: TextStyle(fontSize: 60),
          );
        });
  }

  Widget _buildRequestList(trips) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _buildRideDetails(trips, index);
      },
    );
    ;
  }

  Widget _buildRideDetails(_tripRequests, index) {
    bool _toHome = false;
    if (_tripRequests[index].pickup == 'Gate 3' ||
        _tripRequests[index].pickup == 'Gate 4') {
      _toHome = true;
    }
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'From ${_tripRequests[index].pickup} to ${_tripRequests[index].destination}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildDetailRow('Driver:', _tripRequests[index].driver),
            _buildDetailRow('Time:', _toHome ? 'Evening' : 'Morning'),
            _buildDetailRow('Status', _tripRequests[index].status),
            const SizedBox(height: 16),
            _buildButton('Proceed to Payment', () {}),
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
