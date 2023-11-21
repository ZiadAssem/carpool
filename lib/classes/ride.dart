abstract class Ride {
  final String id;
  final String source;
  final String destination;
  final String rider;
  final bool isMorningRide;
  int numberOfSeats;
  String status;

  Ride({
    required this.id,
    required this.source,
    required this.destination,
    required this.rider,
    required this.isMorningRide,
    required this.numberOfSeats,
    required this.status
  });

  void decrementSeats() {
    numberOfSeats--;
  }

  void incrementSeats() {
    numberOfSeats++;
  }
}

class CampusRide extends Ride {
  CampusRide({
    required String id,
    required String source,
    required String rider,
    required int numberOfSeats,
    required String status,
  }) : super(
          id: id,
          source: source,
          rider: rider,
          destination: 'CAMPUS',
          isMorningRide: true,
          numberOfSeats: numberOfSeats,
          status: status,
        );

  factory CampusRide.fromJson(Map<String, dynamic> json) {
    return CampusRide(
      id: json['id'],
      source: json['source'],
      rider: json['rider'],
      numberOfSeats: json['numberOfSeats'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'rider': rider,
      'numberOfSeats': numberOfSeats,
      'status': status,
    };
  }
}

class HomeRide extends Ride {
  HomeRide({
    required String id,
    required String destination,
    required String rider,
    required int numberOfSeats,
    required String status,
  }) : super(
          id: id,
          source: 'CAMPUS',
          destination: destination,
          rider: rider,
          isMorningRide: false,
          numberOfSeats: numberOfSeats,
          status: status,
        );

  factory HomeRide.fromJson(Map<String, dynamic> json) {
    return HomeRide(
      id: json['id'],
      destination: json['destination'],
      rider: json['rider'],
      numberOfSeats: json['numberOfSeats'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': 'CAMPUS',
      'destination': destination,
      'rider': rider,
      'numberOfSeats': numberOfSeats,
      'status': status,
    };
  }
}
