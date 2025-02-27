import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memora_app/core/services/auth.service.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/input.widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logos/logo-dark-word.svg',
              width: 228,
              height: 32,
            ),
            Text(
              'Des souvenirs que vous pouvez toucher.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.2,
                  ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
        toolbarHeight: 106,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          spacing: 24,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 24,
                    children: [
                      InputWidget(
                        label: 'Quel est ton prénom ?',
                        placeholder: 'John',
                        controller: _nameController,
                      ),
                      InputWidget(
                        label: 'Quel est ton adresse mail ?',
                        placeholder: 'john.doe@gmail.com',
                        controller: _emailController,
                      ),
                      InputWidget(
                        label: 'Choisis ton mot de passe ?',
                        placeholder: 'Mot de passe',
                        controller: _passwordController,
                        obscureText: true,
                      ),
                    ],
                  ),
                  ButtonWidget(
                    label: 'Créer mon compte',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.big,
                    onPressed: () async {
                      await AuthService().signup(
                        // name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                    },
                    fullWidth: true,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tu as déjà un compte ? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login_page');
                  },
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
