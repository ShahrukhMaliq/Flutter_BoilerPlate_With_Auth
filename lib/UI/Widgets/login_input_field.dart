import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final IconData icon;
  final String hintText;
  final bool isPassword;

  const LoginInputField(
      {Key? key,
      required this.onChanged,
      required this.icon,
      required this.isPassword,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      width: MediaQuery.of(context).size.width / 5,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 30),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white),
        obscureText: isPassword,
        keyboardType: !isPassword ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Colors.white),
        ),
        onChanged: this.onChanged,
      ),
    );
  }
}
