abstract class Ride {
  final String id;
  final String source;
  final String destination;
  final String rider;
  final bool isMorningRide;
  int numberOfSeats;
  int price;
  String status;

  Ride({
    required this.id,
    required this.source,
    required this.destination,
    required this.rider,
    required this.isMorningRide,
    required this.numberOfSeats,
    required this.price,
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
    required   int price,

    required String status,
  }) : super(
          id: id,
          source: source,
          rider: rider,
          destination: 'CAMPUS',
          isMorningRide: true,
          numberOfSeats: numberOfSeats,
          price: price,
          status: status,
        );

  factory CampusRide.fromJson(Map<String, dynamic> json) {
    return CampusRide(
      id: json['id'],
      source: json['source'],
      rider: json['rider'],
      numberOfSeats: json['numberOfSeats'],
      price: json['price'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'rider': rider,
      'numberOfSeats': numberOfSeats,
      'price': price,
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
    required int price,
    required String status,
  }) : super(
          id: id,
          source: 'CAMPUS',
          destination: destination,
          rider: rider,
          isMorningRide: false,
          numberOfSeats: numberOfSeats,
          price: price,
          status: status,
        );

  factory HomeRide.fromJson(Map<String, dynamic> json) {
    return HomeRide(
      id: json['id'],
      destination: json['destination'],
      rider: json['rider'],
      numberOfSeats: json['numberOfSeats'],
      price: json['price'],
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
      'price': price,
      'status': status,
    };
  }
}
