import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxs_login_fg/login/model/social_login_interface.dart';

import 'package:rxs_login_fg/login/model/user_model.dart';

import 'package:rxs_login_fg/login/service/auth_manager.dart';
import 'package:rxs_login_fg/login/service/cache_manager.dart';
import 'package:rxs_login_fg/login/service/login_service.dart';

import 'package:rxs_login_fg/widget/icon/circular_button.dart';
import 'package:rxs_login_fg/widget/icon/social_icon.dart';
import 'package:rxs_login_fg/widget/input/input_field.dart';
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

class _LoginViewState extends State<LoginView>
    with CacheManager, SingleTickerProviderStateMixin {
  final ISocialLogin _facebookLogin = FacebookLogin();
  final ISocialLogin _googleLogin = GoogleLogin();
  // final ISocialLogin _twitterLogin = TwitterLogin();

  Future<void> _checkUserControl(String name, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (login(name, password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Correct login!"),
        ),
      );
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

//Animation Controller ...
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> sizeAnimation;
  int currentState = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 60).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    sizeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 200)),
            Image.asset(
              'assets/images/rixos_logo.png',
              width: size.width * 0.60,
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            //Social Login Buttons(Google and Facebook)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
              child: OrDivider(
                customColor: Colors.brown,
              ),
              onTap: () {
                setState(() {
                  hideLogin = !hideLogin;
                  if (hideLogin == false) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                });
              },
            ),
            Padding(padding: CustomPadding()),

            Positioned(
              bottom: 0,
              child: Transform.scale(
                scale: sizeAnimation.value,
                child: SizedBox(
                  width: size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NormalInputField(
                          data: Theme.of(context),
                          controller: usernameInput,
                          onChanged: (text) {},
                          title: "Sicil Numarası veya Kullanıcı Adı"),
                      Padding(padding: CustomPadding()),
                      PasswordInputField(
                          controller: passwordInput,
                          title: "Şifre",
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
                      const Padding(padding: EdgeInsets.all(5)),
                      GestureDetector(
                        child: Container(
                          width: size.width * 0.6,
                          child: Text("Şifremi Unuttum",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown)),
                        ),
                        onTap: () {
                          const UserSelectSheet().show(context);
                        },
                      ),
                      Padding(padding: CustomPadding()),
                      CircularButton(
                        title: "Oturum Aç",
                        onPressed: () async {
                          setState(() {
                            _checkUserControl(
                                usernameInput.text, passwordInput.text);
                            LoginService().loginUser(
                                usernameInput.text, passwordInput.text);
                          });
                        },
                      ),
                      Padding(padding: CustomPadding()),
                       //Don't have an Account? Singup
             Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      const Padding(padding: EdgeInsets.all(5)),
                      GestureDetector(
                        child: Text("Sign up",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () {
                          print("test");
                        },
                      )
                    ],
                  ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
