import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/core/injector/repositories.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';
import 'package:riverpod/riverpod.dart';

part 'planets_state.dart';

final planetsProvider = NotifierProvider<PlanetsProvider, PlanetsState>(
  PlanetsProvider.new,
);

class PlanetsProvider extends Notifier<PlanetsState> {
  late final IPlanetsRepository _planetsRepository;

  @override
  PlanetsState build() {
    _planetsRepository = ref.read(Repositories.planets);
    all();
    return const PlanetsLoading();
  }

  Future<void> all() async {
    final result = await _planetsRepository.all();
    state = switch (result) {
      Success(:final data) => PlanetsLoaded(data),
      Failure() => const PlanetsError(),
    };
  }
}
