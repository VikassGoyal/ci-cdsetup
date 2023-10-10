import 'package:conet/constants/enums.dart';

///
/// App environment configuration.
///
class AppConfig {
  /// Current environment type.
  final EnvironmentType environmentType = EnvironmentType.production;

  AppConfig() {
    // Load environment configuration from environment type.
    switch (environmentType) {
      case EnvironmentType.development:
        _initDevelopment();
        break;
      case EnvironmentType.staging:
        _initStaging();
        break;
      case EnvironmentType.production:
        _initProduction();
        break;
    }

    print('Initialised App config');
  }

  /// Base URL for API calls.
  late final String baseApiUrl;

  ///
  /// Initialize Dev.
  ///
  void _initDevelopment() {
    baseApiUrl = 'http://konet.in';
  }

  ///
  /// Initialize Staging.
  ///
  void _initStaging() {
    throw UnimplementedError('Staging environment not implemented.');
  }

  ///
  /// Initialize Production.
  ///
  void _initProduction() {
    baseApiUrl = 'http://konet.in';
  }
}
