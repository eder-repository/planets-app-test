import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/data/data.dart';

class PlanetsRemoteDatasource implements IPlanetsRemoteDatasource {
  PlanetsRemoteDatasource({required Http http}) : _http = http;

  final Http _http;
  @override
  FutureHttpRequest<List<PlanetModel>> all() {
    return performHttpRequest(
      _http.send(
        APIPaths.all,
        parser: (_, list) => (list['data'] as List).mapList(
          (json) => PlanetModel.fromJson(json as Json),
        ),
      ),
    );
  }
}
