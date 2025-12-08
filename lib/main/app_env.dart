enum AppEnvironment { dev, stage, prod }

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.dev;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get appName => _environment._appTitle;

  static String get envName => _environment._envName;

  static String get connectionString => _environment._connectionString;

  static String get baseUrl => _environment._baseUrls;

  static String get webPageUrl => _environment._webPageUrls;

  static AppEnvironment get environment => _environment;

  static bool get isProduction => _environment == AppEnvironment.prod;
}

extension _EnvProperties on AppEnvironment {
  static const _appTitles = {
    AppEnvironment.dev: 'BLOC Dev',
    AppEnvironment.stage: 'BLOC Staging',
    AppEnvironment.prod: 'BLOC Prod',
  };

  static const _connectionStrings = {
    AppEnvironment.dev: '',
    AppEnvironment.stage: '',
    AppEnvironment.prod: '',
  };

  static const _baseUrl = {
    AppEnvironment.dev: 'https://dummyjson.com/',
    AppEnvironment.stage: 'https://dummyjson.com/',
    AppEnvironment.prod: 'https://dummyjson.com/',
  };

  static const _envs = {
    AppEnvironment.dev: 'dev',
    AppEnvironment.stage: 'uat',
    AppEnvironment.prod: 'prod',
  };

  static const _webPageUrl = {
    AppEnvironment.dev: 'http://example1.com',
    AppEnvironment.stage: 'https://bexample2.com',
    AppEnvironment.prod: 'https://example3.com',
  };

  String get _appTitle => _appTitles[this]!;

  String get _envName => _envs[this]!;

  String get _connectionString => _connectionStrings[this]!;

  String get _baseUrls => _baseUrl[this]!;

  String get _webPageUrls => _webPageUrl[this]!;
}
