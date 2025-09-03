enum Environments {
  dev(),
  staging(),
  prod();

  const Environments();

  bool get enableLogging => this != Environments.prod;
}
