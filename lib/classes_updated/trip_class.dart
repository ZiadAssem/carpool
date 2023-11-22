import 'Routes.dart';

class Trip {
  Route route;
  int gate;
  int price;
  String driver;
  String numberOfSeatsLeft;
  String status;
  DateTime date; // Added date property

  Trip({
    required this.route,
    required this.gate,
    required this.driver,
    required this.numberOfSeatsLeft,
    required this.price,
    required this.status,
    required this.date, // Added date parameter
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      route: Route.fromJson(json['route']),
      gate: json['gate'],
      driver: json['driver'],
      numberOfSeatsLeft: json['numberOfSeatsLeft'],
      price: json['price'],
      status: json['status'],
      date: DateTime.parse(json['date']), // Parse date from JSON string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'route': route,
      'gate': gate,
      'driver': driver,
      'numberOfSeatsLeft': numberOfSeatsLeft,
      'price': price,
      'status': status,
      'date': date.toIso8601String(), // Convert date to ISO 8601 string
    };
  }
}

class HomeTrip extends Trip {
  HomeTrip({
    required route,
    required gate,
    required driver,
    required numberOfSeatsLeft,
    required price,
    required status,
    required date,
  }) : super(
          route: route,
          gate: gate,
          driver: driver,
          numberOfSeatsLeft: numberOfSeatsLeft,
          price: price,
          status: status,
          date: date,
        );
}

class CampusTrip extends Trip {
  CampusTrip({
    required route,
    required gate,
    required driver,
    required numberOfSeatsLeft,
    required price,
    required status,
    required date,
  }) : super(
          route: route,
          gate: gate,
          driver: driver,
          numberOfSeatsLeft: numberOfSeatsLeft,
          price: price,
          status: status,
          date: date,
        );
}

class TripRequest {
  Trip trip;
  String rider;
  String status;

  TripRequest({
    required this.trip,
    required this.rider,
    required this.status,
  });

  factory TripRequest.fromJson(Map<String, dynamic> json) {
    return TripRequest(
      trip: Trip.fromJson(json['trip']),
      rider: json['rider'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip': trip,
      'rider': rider,
      'status': status,
    };
  }
}