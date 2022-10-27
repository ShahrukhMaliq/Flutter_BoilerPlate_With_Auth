import 'package:Flutter_BoilerPlate_With_Auth/core/models/authentication/user.dart';

class UserDemo {
  static User getDemoUser() {
    return User(userid: "1001", login: "Demo user", userrole: "Demo Role");
  }
}
