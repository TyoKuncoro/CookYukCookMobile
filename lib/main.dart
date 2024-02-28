import 'package:flutter/material.dart';

void main() => runApp(const Login());

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Map<String, String> formField = <String, String>{};
  callback() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();
      formField.forEach(
        (label, value) => print('$label = $value'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              Image.asset(
                "assets/images/cyc.png",
              ),
              textField('E-mail', false, validateEmail),
              textField('Password', true, validatePassword),
              Button(text: 'Login', callback: callback),
            ],
          ),
        ),
      ),
    ));
  }

  Widget textField(String label, bool obscure, Function validation) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          obscureText: obscure,
          validator: (String? value) {
            return validation(value);
          },
          onSaved: (String? val) {
            if (val != null) {
              formField[label] = val;
            }
          }
          //  => formField[label] = val,
          ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Function callback;
  const Button({super.key, required this.text, required this.callback});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          callback();
        },
        child: const Text('Login'));
  }
}

String? validateEmail(formText) {
  if (formText.isEmpty) {
    return 'E-mail tidak boleh kosong';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formText)) {
    return 'Format E-mail salah';
  }
  return null;
}

String? validatePassword(formPassword) {
  if (formPassword.isEmpty) {
    return 'Password tidak boleh kosong';
  }
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return 'Password harus memuat huruf besar, kecil, simbol dan 8 karakter';
  }
  return null;
}

String? validateText(formText) {
  if (formText.isEmpty) {
    return 'Input tidak boleh kosong!';
  }
  return null;
}
