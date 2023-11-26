import 'package:flutter/material.dart';
import '../classes/ride.dart';
import '../classes_updated/trip_class.dart';

class TripDetails extends StatefulWidget {
  const TripDetails(
      {super.key,
      required this.trip,
      required this.location,
      required this.isHomeRide});
  final Trip trip;
  final String location;
  final bool isHomeRide;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
        backgroundColor: const Color.fromARGB(255, 142, 15, 6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTripDetails(),
              const SizedBox(height: 16),
              _buildRequestTripButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripDetails() {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildtripDestination(),
            const SizedBox(height: 8),
            _buildDetailRow('Rider:', widget.trip.driver),
            _buildDetailRow(
                'Time:', widget.isHomeRide ? 'Evening' : 'Morning'),
            _buildDetailRow(
                'Available Seats:', widget.trip.numberOfSeatsLeft.toString()),
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

  Widget _buildRequestTripButton() {
    return ElevatedButton(
      onPressed: () {
        showConfirmationMenu(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 142, 15, 6),
        padding: const EdgeInsets.all(16),
      ),
      child: const Text(
        'Request trip',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void showConfirmationMenu(BuildContext context) async {
    final selectedOption = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          10, MediaQuery.of(context).size.height * 0.5, 0, 0),
      items: [
        _buildPopUpMenuItem('Confirm', const Icon(Icons.check)),
        _buildPopUpMenuItem("Cancel", const Icon(Icons.cancel)),
      ],
      elevation: 8.0,
    );

    // Handle the selected option
    _handleSelectedOption(selectedOption);
  }

  PopupMenuItem _buildPopUpMenuItem(String text, Icon icon) {
    return PopupMenuItem(
      value: text,
      child: ListTile(
        title: Text(text),
        leading: icon,
      ),
    );
  }

  void _handleSelectedOption(selectedOption) {
    if (selectedOption == 'Confirm') {
      // Perform action for confirmation
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('trip Requested'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (selectedOption == 'Cancel') {
      // Perform action for cancel
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('trip Request Cancelled'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildtripDestination() {
    if (widget.isHomeRide) {
      return Text(
        'From ${widget.trip.gate} to ${widget.location}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
    return Text(
      'From ${widget.location} to ${widget.trip.gate}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
