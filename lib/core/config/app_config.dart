enum Environment { dev, staging, prod }

class AppConfig {
  static Environment _environment = Environment.dev;
  
  static Environment get environment => _environment;
  
  static void setEnvironment(Environment env) {
    _environment = env;
  }
  
  static String get baseUrl {
    switch (_environment) {
      case Environment.dev:
        return 'https://dev-api.healthcare.com';
      case Environment.staging:
        return 'https://staging-api.healthcare.com';
      case Environment.prod:
        return 'https://api.healthcare.com';
    }
  }
  
  static bool get isProduction => _environment == Environment.prod;
  static bool get enableLogging => _environment != Environment.prod;
  
  // Healthcare compliance settings
  static const int sessionTimeoutMinutes = 15;
  static const bool enableBiometricAuth = true;
  static const int maxLoginAttempts = 3;
}