

# Introduction 
Flutter_BoilerPlate_With_Auth

Resuable App Architecture with generic authentication mechanisms, BLoC state management, folder structure, multiple flavors config, API Client, sample login page. The boiler plate also contains app authentication reactor, app lifecycle observer. 
Using this boiler plate one can easily reach a boilter plate to develop a huge-sized Flutter app. 
Two types of Authentication are covered:
1. External Login
2. Credentials based Login

The sample Login page is only intended for example purposes and designed for a web-based application. 
![image](https://user-images.githubusercontent.com/23314441/198387317-8e34bff0-a6e2-49bf-9dad-51cc051124cb.png)
# Usage
At the main please provide the Base URL and the authorization endpoint. 

```
void main() async {
  FlavorConfig(
      flavor: Flavor.DEV,
      envColor: Colors.redAccent.shade100,
      supportedLanguages: [Language.DE, Language.EN, Language.FR, Language.IT],
      values: FlavorValues(
          baseUrl: "", //please provide baseUrl
          authenticationCredentialsConfig: AuthenticationCredentialsConfig(
              title: 'Login', authorizationEndpoint: ''), //please provide Authorization endpoint
          privacyNoticeUrl: "https://dev.to",
          contactInfoUrl: "https://dev.to",
          themeConfig: ThemeConfig(),
          logo: "assets/images/logo.png")); //logo in assets
  WidgetsFlutterBinding?.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(MyApp());
}
```

For external login please provide authenticationExternalConfig in the Flavor values.
```
values: FlavorValues(
          baseUrl: "", //please provide baseUrl
          authenticationExternalConfig: AuthenticationExternalConfig(
              title: 'Login IDP',
              authorizationAuthorizationEndpoint: "",
              authorizationTokenEndpoint: "",
              authorizationAppIdentifier: "",
              authorizationAppSecret: "",
              authorizationRedirectUrl: "",
              logoutUrl: "")
```
In the User repository please provide the  endpoint URL for the credentials based login 
```
class UserRepository {
  ApiClient _apiClient = ApiClient();

  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  UserRepository._internal();

  Future<User> getUser() async {
    if (FlavorConfig.isDemo()) {
      return User(login: "test_user");
    }

    String url = 'api/myapi/user'; //endpoint for authenticating user
    var responseJson = await _apiClient.getJson(url);
    var result = User.fromJson(responseJson);

    return result;
  }
}

```
# Getting Started
1. Install Flutter SDK: https://flutter.dev/docs/get-started/install/windows
2. Install missing packages: flutter packages get / Flutter pub get
3. Switch channel to DEV: flutter channel dev
4. Upgrade Flutter: flutter upgrade

# Starting app
1. Test - flutter run -t lib/main_test.dart
2. DEV - flutter run -t lib/main_dev.dart
3. PRODUCTION - flutter run -t lib/main_prod.dart

# Useful Commands
1. Start Build Runner to generate .g files: flutter packages pub run build_runner build --delete-conflicting-outputs 
2. Generate translation files: flutter gen-l10n

