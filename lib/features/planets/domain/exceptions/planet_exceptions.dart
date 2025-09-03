/// Represents all possible exceptions related to Planets domain.
sealed class PlanetException {
  const PlanetException();
}

/// Thrown when the requested planet is not found.
final class PlanetNotFoundException extends PlanetException {
  const PlanetNotFoundException();
}

/// Thrown when access is denied due to missing or invalid credentials.
final class PlanetUnauthorizedException extends PlanetException {
  const PlanetUnauthorizedException();
}

/// Thrown when a server error or network issue occurs while fetching planets.
final class PlanetServerException extends PlanetException {
  const PlanetServerException();
}

/// Thrown when no cached planets are available locally.
final class PlanetCacheException extends PlanetException {
  const PlanetCacheException();
}
