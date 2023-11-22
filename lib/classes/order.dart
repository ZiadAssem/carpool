import 'package:carpool/classes/ride.dart';

class Trip{
  Ride ride;
  String gate;

  Trip({required this.ride, required this.gate});

 


}

class CampusTrip extends Trip{
  CampusTrip({required CampusRide ride, required String gate}) : super(ride: ride, gate: gate);

  CampusTrip.fromJson(Map<String, dynamic> json) : super(ride: CampusRide.fromJson(json), gate: json['gate']);

  
}

class HomeTrip extends Trip{
  HomeTrip({required HomeRide ride, required String gate}) : super(ride: ride, gate: gate);

  HomeTrip.fromJson(Map<String, dynamic> json) : super(ride: HomeRide.fromJson(json), gate: json['gate']);
}