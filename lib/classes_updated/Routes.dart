class Route {
  String? location;

  Route({required this.location});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      location: json['location'],
    );
  }


  
}

class HomeRoute extends Route{

  HomeRoute({ required location}):super( location: location);

}

class CampusRoute extends Route{

  CampusRoute({ required location}):super( location: location);

}