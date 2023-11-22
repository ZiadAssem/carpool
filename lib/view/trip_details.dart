import 'package:flutter/material.dart';
import '../classes/ride.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key, required this.ride});
  final Ride ride;

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
              _buildRideDetails(),
              const SizedBox(height: 16),
              _buildRequestRideButton(),
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
            Text(
              'From ${widget.ride.source} to ${widget.ride.destination}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Rider:', widget.ride.rider),
            _buildDetailRow(
                'Time:', widget.ride.isMorningRide ? 'Morning' : 'Evening'),
            _buildDetailRow(
                'Available Seats:', widget.ride.numberOfSeats.toString()),
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

  Widget _buildRequestRideButton() {
    return ElevatedButton(
      onPressed: () {
        showConfirmationMenu(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 142, 15, 6),
        padding: const EdgeInsets.all(16),
      ),
      child: const Text(
        'Request Ride',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void showConfirmationMenu(BuildContext context) async {
    final selectedOption = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(10, MediaQuery.of(context).size.height*0.5, 0, 0),
      items: [
        _buildPopUpMenuItem('Confirm', const Icon(Icons.check)),

       _buildPopUpMenuItem("Cancel",const Icon(Icons.cancel)),
      ],
      elevation: 8.0,
    );

    // Handle the selected option
    _handleSelectedOption(selectedOption);
  }

  PopupMenuItem _buildPopUpMenuItem(String text,Icon icon){
    return  PopupMenuItem(
          value:text,
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
          content: Text('Ride Requested'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (selectedOption == 'Cancel') {
      // Perform action for cancel
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ride Request Cancelled'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
