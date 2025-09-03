enum PlanetsRoutes {
  splash._(name: 'Splash', path: '/splash'),
  homePlanets._(name: 'HomePlanets', path: '/'),
  planets._(name: 'Planets', path: '/planets'),
  planetDetails._(name: 'PlanetDetails', path: '/planets/:id');

  const PlanetsRoutes._({required this.name, required this.path});
  final String name;
  final String path;
}
