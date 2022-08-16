import 'package:flutter/material.dart';
import 'package:rxs_login_fg/widget/icon/circular_button.dart';
import 'package:rxs_login_fg/widget/input/normal_input_field.dart';



class ForgottenColumn extends StatefulWidget {
  const ForgottenColumn({Key? key}) : super(key: key);

  @override
  _ForgottenColumnState createState() => _ForgottenColumnState();
}

class _ForgottenColumnState extends State<ForgottenColumn> {
  final String _title = "Send Password";
  TextEditingController emailInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        const Divider(indent: 150, endIndent: 150),
        const Padding(padding: EdgeInsets.all(10)),
        Image.asset(
          'assets/logos/petlogo.png',
          width: size.width * 0.50,
        ),
        const Padding(padding: EdgeInsets.all(10)),
        NormalInputField(
          data: Theme.of(context),
          title: 'Email Address',
          controller: emailInput,
          onChanged: (text) {},
        ),
        const Padding(padding: EdgeInsets.all(10)),
        CircularButton(title: _title, onPressed: () async {}),
      ],
    );
  }
}
