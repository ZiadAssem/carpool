class Trip {
  // Route route;
  String tripId;
  String gate;
  int price;
  String driverId;
  int numberOfSeatsLeft;
  String status;
  String date;
  String route;
  String destination;
  bool isMorningTrip;

  Trip({
    required this.tripId,
    required this.gate,
    required this.driverId,
    required this.numberOfSeatsLeft,
    required this.price,
    required this.status,
    required this.date,
    required this.route,
    required this.destination,
    required this.isMorningTrip,
    
    
  });

  factory Trip.fromJson(json) {
     if (json == null) {
      // Handle the case where the JSON data is null
      // You can return a default instance or throw an exception, depending on your use case
      throw FormatException("JSON data is null");
    }

    // Ensure that the required fields are present in the JSON

    // if (json['tripId']==null) {
    //   throw FormatException("Required field tripId is missing");
    // }
    // if (json['gate']==null) {
    //   throw FormatException("Required field gate is missing");
    // }
    // if (json['driverId']==null) {
    //   throw FormatException("Required field driverId is missing");
    // }
    // if (json['numberOfSeatsLeft']==null) {
    //   throw FormatException("Required field numberOfSeatsLeft is missing");
    // }
    // if (json['price']==null) {
    //   throw FormatException("Required field price is missing");
    // }
    // if (json['status']==null) {
    //   throw FormatException("Required field status is missing");
    // }
    // if (json['date']==null) {
    //   throw FormatException("Required field date is missing");
    // }
    // if (json['route']==null) {
    //   throw FormatException("Required field route is missing");
    // }
    // if (json['destination']==null) {
    //   throw FormatException("Required field destination is missing");
    // }
    // if (json['isMorningTrip']==null) {
    //   throw FormatException("Required field isMorningTrip is missing");
    // }



    return Trip(
        // route: Route.fromJson(json['route']),
        tripId: json['tripId'],
        gate: json['gate'],
        driverId: json['driverId'],
        numberOfSeatsLeft: json['numberOfSeatsLeft'],
        price: json['price'],
        status: json['status'],
        date: json['date'],
        route: json['route'],
        destination: json['destination'],
        isMorningTrip: json['isMorningTrip']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'route': route,
      'tripId': tripId,
      'gate': gate,
      'driverId': driverId,
      'numberOfSeatsLeft': numberOfSeatsLeft,
      'price': price,
      'status': status,
      'date': date,
      'route': route,
      'destination': destination,
      'isMorningTrip': isMorningTrip

      // Convert date to ISO 8601 string
    };
  }
}

// class HomeTrip extends Trip {
//   HomeTrip({
//   //  required route,
//     required tripKey,
//     required gate,
//     required driverId,
//     required numberOfSeatsLeft,
//     required price,
//     required status,
//     required date,
//   }) : super(

//         //  route: route,
//         tripKey: tripKey,
//           gate: gate,
//           driverId: driverId,
//           numberOfSeatsLeft: numberOfSeatsLeft,
//           price: price,
//           status: status,
//           date: date,
//         );
// }

// class CampusTrip extends Trip {
//   CampusTrip({
//  //   required route,
//  required tripKey,
//     required gate,
//     required driverId,
//     required numberOfSeatsLeft,
//     required price,
//     required status,
//     required date,
//   }) : super(
//     //      route: route,
//           tripKey: tripKey,
//           gate: gate,
//           driverId: driverId,
//           numberOfSeatsLeft: numberOfSeatsLeft,
//           price: price,
//           status: status,
//           date: date,
//         );
// }



// // class TripRequest {
// //   Trip trip;
// //   String rider;
// //   String status;

// //   TripRequest({
// //     required this.trip,
// //     required this.rider,
// //     required this.status,
// //   });

// //   factory TripRequest.fromJson(Map<String, dynamic> json) {
// //     return TripRequest(
// //       trip: Trip.fromJson(json['trip']),
// //       rider: json['rider'],
// //       status: json['status'],
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'trip': trip,
// //       'rider': rider,
// //       'status': status,
// //     };
// //   }
// // }

