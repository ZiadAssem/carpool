import 'dart:async';

import 'package:carpool/classes_updated/routes_class.dart';
import 'package:carpool/classes_updated/triprequest_class.dart';
import 'package:carpool/firebase/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import '../classes_updated/user_class.dart';
import '../classes_updated/trip_class.dart';

class DatabaseHelper {
  final DatabaseReference reference = FirebaseDatabase.instance.ref();
  // late String currentUserId;
  late User currentUser;

  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();
  static DatabaseHelper get instance => _instance;

  // check database
  Future checkDatabase() async {
    try {
      await reference.get().timeout(
            const Duration(seconds: 5),
            onTimeout: () => throw TimeoutException("Time out 1111"),
          );
      print("Connected to database");
    } catch (error) {
      print("Error connecting to database: $error");
      return false;
    }
  }

  // Add a new data to the database
  Future<void> addData(String path, Map<String, dynamic> data) async {
    await reference.child(path).push().set(data);
  }

  // Update an existing data in the database
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await reference.child(path).update(data);
  }

  // Remove a data from the database
  Future<void> removeData(String path) async {
    await reference.child(path).remove();
  }

  // Retrieve data from the database
  Future<DatabaseEvent> getData(String path) async {
    return await reference.child(path).once();
  }

  //updated
  Future<List> getRoutesFromDb() async {
    final event = await reference.child('Routes').once();

    Map<dynamic, dynamic> values =
        event.snapshot.value as Map<dynamic, dynamic>;

    List routes = [];
    values.forEach((key, value) {
      routes.add(value['location']);
    });
    routes.toSet().toList();
    return routes;
  }

  //updated
  Future<List<List<Trip>>> getTripsFromDb(String route) async {
    List<List<Trip>> trips = [];
    List<Trip> campusTripsDb = [];
    List<Trip> homeTripsDb = [];
    Map<dynamic, dynamic>? campusValues;
    Map<dynamic, dynamic>? homeValues;
    DateTime now = DateTime.now();
    DateTime onePM = DateTime(now.year, now.month, now.day+1, 13, 0, 0);
    DateTime tenPM = DateTime(now.year, now.month, now.day, 22, 0, 0);
    DateTime sevenThirtyAM = DateTime(now.year, now.month, now.day, 7, 30, 0);
    DateTime fiveThirtyPM = DateTime(now.year, now.month, now.day, 17, 30, 0);

    print('route: $route');

    try {
      final campusEvent =
          await reference.child('Trips').child('Campus').child(route).once();

      final homeEvent =
          await reference.child('Trips').child('Home').child(route).once();

      if (campusEvent.snapshot.value != null) {
        campusValues = campusEvent.snapshot.value as Map<dynamic, dynamic>?;
      }
      if (homeEvent.snapshot.value != null) {
        homeValues = homeEvent.snapshot.value as Map<dynamic, dynamic>?;
      }
      print('test 2');
      if (campusValues != null) {
        campusValues.forEach((key, value) {
          final parsedDate = DateTime.parse(value['date']);
          print(parsedDate);

          if (parsedDate.isAfter(now) && now.isBefore(tenPM)) {
            print('success');
            campusTripsDb.add(Trip.fromJson(value));
          }
        });
      }
      print('test 3');
      if (homeValues != null) {
        homeValues.forEach((key, value) {
          final parsedDate = DateTime.parse(value['date']);
          print(parsedDate);

          if (parsedDate.isAfter(now) && now.isBefore(onePM)) {
            print('success');
            homeTripsDb.add(Trip.fromJson(value));
          }
        });
      }
      trips = [campusTripsDb, homeTripsDb];
      print('trips: $trips');
    } catch (error) {
      print("Error fetching trips: $error");
      // Handle the error as needed
    }

    return trips;
  }

  //updated
  addUserToDb(Map<String, dynamic> data, String currentUserId) async {
    await reference.child('Users/').set(data);
  }

  getCurrentUser() async {
    final event = await reference
        .child('Users/${Authentication.instance.currentUserId}')
        .once();
    Map<dynamic, dynamic> values =
        event.snapshot.value as Map<dynamic, dynamic>;
    currentUser = User.fromJson(values);
        print('Current user is $currentUser');

    return currentUser;
  }
  //updated

  requestTrip(String userId, Map<String, dynamic> data) async {
    final driverId = data['driver'];
    //generate key
    final generatedKey =
        reference.child('TripRequests').child(data['tripId']).push().key;
    data['requestId'] = generatedKey;

    //TripRequests/tripId/requestId/requestData
    await reference
        .child('/TripRequests')
        .child(data['tripId'])
        .child(generatedKey!)
        .set(data);
    await reference
        .child('Users')
        .child(driverId)
        .child('TripRequests')
        .child(generatedKey)
        .set(data);
  }

  getAcceptedTripData(String userId) async {
    List<TripRequest> tripRequests = [];

    final event = await reference.child('TripRequests').once();
    //check if event has data
    if (event.snapshot.value == null) {
      return tripRequests;
    }
    Map<dynamic, dynamic> values =
        event.snapshot.value as Map<dynamic, dynamic>;

    print(values);

    values.forEach((key, value) {
      print('key is $key');
      print('value is $value');
      value.forEach((requestId, requestData) {
        print('request id is $requestId');
        print('request data is $requestData');
        if (requestData['user'] == userId) {
          if (requestData['status'] == 'accepted' || requestData['status'] == 'awaiting') {
            tripRequests.add(TripRequest.fromJson(requestData));
          }
        }
      });
    });

    print('testingggggg $tripRequests');
    print(tripRequests.length);
    return tripRequests;
  }
  // getUserId(email){
  //   Authentication.currentUserId = email.replaceAll("@eng.asu.edu.eg", "");
  // }

  getCompletedTrips(String userId) async {
    final event = await reference.child('TripRequests').once();

    Map<dynamic, dynamic> values =
        event.snapshot.value as Map<dynamic, dynamic>;
    print(values);

    List<TripRequest> tripRequests = [];
    values.forEach((key, value) {
      print('key is $key');
      print('value is $value');
      value.forEach((requestId, requestData) {
        print('request id is $requestId');
        print('request data is $requestData');
        if (requestData['user'] == userId) {
          if (requestData['status'] == 'completed') {
            tripRequests.add(TripRequest.fromJson(requestData));
          }
        }
      });
     
    });
    print('trip requests $tripRequests');
    return tripRequests;
  }
}
