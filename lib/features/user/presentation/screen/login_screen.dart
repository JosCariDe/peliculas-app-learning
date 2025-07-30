import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerEmail = TextEditingController();
    TextEditingController _controllerPassword = TextEditingController();

    final styles = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //? Titulos
            Column(
              children: [
                Text('Login', style: styles.bodyLarge),
                Text('Welcome Bajarangisoft', style: styles.bodyMedium),
              ],
            ),
            //? Formulario con 2 campos (email, password)
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  //? Email
                  TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      labelText: 'Ingresa su Texto',
                      hintText: 'Escribe aquí..',
                    ),
                    onChanged: (text) {
                      debugPrint('Texto actual: $text');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
