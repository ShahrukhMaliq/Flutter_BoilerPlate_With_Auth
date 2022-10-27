import 'dart:ui';
import 'package:Flutter_BoilerPlate_With_Auth/UI/Widgets/login_input_field.dart';
import 'package:Flutter_BoilerPlate_With_Auth/UI/pages/common/view/splash_page.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/enums/authentication_status.dart';
import 'package:Flutter_BoilerPlate_With_Auth/core/utils/toast_utils.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/authentication/authentication_bloc.dart';
import 'package:Flutter_BoilerPlate_With_Auth/domain/BLoC/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _emailText;
  String? _passwordText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authenticationState) {
      return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
        if (loginState.isPreparing! ||
            authenticationState.status == AuthenticationStatus.authenticating) {
          return SplashPage();
        }
        return Scaffold(
            //Main container of page
            body: Container(
                width: double.infinity,
                height: double.infinity,
                //Background Image
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/login-background.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                //Backdrop filter blurs the background image
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            //Left part of the card: which includes logo &  text.
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 1.9,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 90.0, left: 20.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image.asset(
                                          'images/logo.png',
                                          height: 250,
                                          width: 300,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                        child: const Text(
                                          "MY APP TITLE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 1.9,
                              width: 1.0,
                              color: Colors.white,
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            ), //Right part of the card: contains login fields.
                            Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.only(
                                  top: 70.0, right: 70.0, left: 70.0, bottom: 40.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  //InputFields
                                  LoginInputField(
                                      onChanged: (text) => this.setState(() {
                                            _emailText = text;
                                          }),
                                      icon: Icons.account_circle_outlined,
                                      isPassword: false,
                                      hintText: 'Username...'),

                                  const SizedBox(height: 20.0),

                                  LoginInputField(
                                      onChanged: (text) => this.setState(() {
                                            _passwordText = text;
                                          }),
                                      icon: Icons.lock_outline,
                                      isPassword: true,
                                      hintText: 'Password...'),

                                  const SizedBox(height: 30.0),

                                  TextButton(
                                      onPressed: () {
                                        var isButtonEnabled =
                                            _emailText != null && _passwordText != null;
                                        isButtonEnabled
                                            ? context.read<LoginBloc>().add(
                                                CredentialsLoginEvent(_emailText!, _passwordText!))
                                            : ToastUtils.showToast(
                                                'Please enter username and password');
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.indigo,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 80),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)))),
                                  const SizedBox(height: 10.0),
                                  authenticationState.status ==
                                              AuthenticationStatus.unauthenticated &&
                                          loginState.authenticationFailed != null
                                      ? Text(
                                          'Invalid username or password',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Text('')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
      });
    });
  }
}
