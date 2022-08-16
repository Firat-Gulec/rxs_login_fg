import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxs_login_fg/login/model/social_login_interface.dart';

import 'package:rxs_login_fg/login/model/user_model.dart';

import 'package:rxs_login_fg/login/service/auth_manager.dart';
import 'package:rxs_login_fg/login/service/cache_manager.dart';
import 'package:rxs_login_fg/login/service/login_service.dart';

import 'package:rxs_login_fg/widget/icon/circular_button.dart';
import 'package:rxs_login_fg/widget/icon/social_icon.dart';
import 'package:rxs_login_fg/widget/input/normal_input_field.dart';
import 'package:rxs_login_fg/widget/input/password_input_field.dart';
import 'package:rxs_login_fg/widget/padding/custom_padding.dart';
import 'package:rxs_login_fg/widget/padding/or_divider.dart';
import 'package:rxs_login_fg/widget/sheet/select_sheet.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with CacheManager {
  final ISocialLogin _facebookLogin = FacebookLogin();
  final ISocialLogin _googleLogin = GoogleLogin();
  // final ISocialLogin _twitterLogin = TwitterLogin();

  Future<void> _checkUserControl(String name, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (login(name, password)) {
      //navigate Profile
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Incorrect login!"),
        ),
      );
    }
  }

  final TextEditingController usernameInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  bool hidePassword = true;
  bool hideLogin = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 200)),
            Image.asset(
              'assets/images/petlogo.png',
              width: size.width * 0.50,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            //Social Login Buttons(Google and Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                    //  text: '',
                    iconSrc: 'assets/images/facebook.png',
                    onPressed: () async {
                      await _facebookLogin.login();
                    }),
                Padding(padding: CustomPadding()),
                SocialIcon(
                    //   text: '',
                    iconSrc: 'assets/images/google.png',
                    onPressed: () async {
                      await _googleLogin.login();
                    }),
                Padding(padding: CustomPadding()),
                SocialIcon(
                    //  text: '',
                    iconSrc: 'assets/images/twitter.png',
                    onPressed: () async {
                      await _facebookLogin.login();
                    }),
                Padding(padding: CustomPadding()),
                SocialIcon(
                    //  text: '',
                    iconSrc: 'assets/images/finger.png',
                    onPressed: () async {
                      await _facebookLogin.login();
                    }),
              ],
            ),
            //Input Login
            GestureDetector(
              child: const OrDivider(),
              onTap: () {
                setState(() {
                  hideLogin = !hideLogin;
                });
              },
            ),
            Visibility(
              visible: hideLogin,
              child: Column(
                children: [
                  NormalInputField(
                      data: Theme.of(context),
                      controller: usernameInput,
                      onChanged: (text) {},
                      title: "Username"),
                  Padding(padding: CustomPadding()),
                  PasswordInputField(
                      controller: passwordInput,
                      title: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(
                          hidePassword == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                        ),
                      ),
                      data: Theme.of(context),
                      obscureText: hidePassword),
                  Padding(padding: CustomPadding()),
                  CircularButton(
                    title: "Sign in",
                    onPressed: () async {
                      setState(() {
                        _checkUserControl(
                            usernameInput.text, passwordInput.text);
                        LoginService()
                            .loginUser(usernameInput.text, passwordInput.text);
                      });
                    },
                  ),
                  Padding(padding: CustomPadding()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(5)),
                      GestureDetector(
                        child: Text("Forgotten password",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () {
                          const UserSelectSheet().show(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 100)),

            //Don't have an Account? Singup
            /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.login_dontAccount.tr()),
                      const Padding(padding: EdgeInsets.all(5)),
                      GestureDetector(
                        child: Text(LocaleKeys.login_signup.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const RegisterForm();
                            },
                          ));
                        },
                      )
                    ],
                  ),*/
          ],
        ),
      ),
    );
  }
}
