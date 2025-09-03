import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/core/injector/repositories.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:riverpod/riverpod.dart';

part 'planets_details_state.dart';

final planetsDetailsProvider =
    NotifierProvider<PlanetsDetailsProvider, PlanetsDetailsState>(
      PlanetsDetailsProvider.new,
    );

class PlanetsDetailsProvider extends Notifier<PlanetsDetailsState> {
  late final IPlanetsRepository _planetsRepository;

  @override
  PlanetsDetailsState build() {
    _planetsRepository = ref.read(Repositories.planets);
    return const PlanetsDetailsLoading();
  }

  Future<void> byId({
    required String id,
  }) async {
    final result = await _planetsRepository.all();
    state = switch (result) {
      Success(:final data) => _details(
        data,
        id,
      ),
      Failure() => const PlanetsDetailsError(),
    };
  }
}

PlanetsDetailsState _details(List<Planet> planets, String id) {
  try {
    final planet = planets
        .where((p) => p.name.toLowerCase() == id.toLowerCase())
        .firstOrNull;
    if (planet == null) {
      return const PlanetsDetailsError();
    }
    return PlanetsDetailsLoaded(planet);
  } catch (e) {
    return const PlanetsDetailsError();
  }
}
