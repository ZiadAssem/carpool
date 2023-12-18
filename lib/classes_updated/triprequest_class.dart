class TripRequest{
  String tripId;
  String requestId;
  String user;
  String driver;
  String status;
  String pickup;
  String destination;
  String tripDate;
  bool isMorningTrip;

  TripRequest({

    required this.tripId,
    required this.requestId,
    required this.driver,
    required this.user,
    required this.status,
    required this.pickup,
    required this.destination,
    required this.tripDate,
    required this.isMorningTrip,
  });

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'requestId': requestId,
      'driver': driver,
      'user': user,
      'status': status,
      'pickup': pickup,
      'destination': destination,
      'tripDate': tripDate,
      'isMorningTrip': isMorningTrip,

    };
  }

  static TripRequest fromJson(value) {
    return TripRequest(
      tripId: value['tripId'],
      requestId: value['requestId'],
      driver: value['driver'],
      user: value['user'],
      status: value['status'],
      pickup: value['pickup'],
      destination: value['destination'],
      tripDate: value['tripDate'],
      isMorningTrip: value['isMorningTrip'],
    );
  }
}