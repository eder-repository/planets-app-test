part of 'planets_provider.dart';

sealed class PlanetsState {
  const PlanetsState();
}

class PlanetsLoading extends PlanetsState {
  const PlanetsLoading();
}

class PlanetsLoaded extends PlanetsState {
  const PlanetsLoaded(this.planets);
  final List<Planet> planets;
}

class PlanetsError extends PlanetsState {
  const PlanetsError();
}
