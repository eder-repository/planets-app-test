part of 'planets_details_provider.dart';

sealed class PlanetsDetailsState {
  const PlanetsDetailsState();
}

class PlanetsDetailsLoading extends PlanetsDetailsState {
  const PlanetsDetailsLoading();
}

class PlanetsDetailsLoaded extends PlanetsDetailsState {
  const PlanetsDetailsLoaded(this.planet);
  final Planet planet;
}

class PlanetsDetailsError extends PlanetsDetailsState {
  const PlanetsDetailsError();
}
