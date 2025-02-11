import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memora_app/core/widgets/button.widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logos/logo-dark-word.svg',
                width: 228,
                height: 32,
              ),
              SizedBox(height: 16),
              Text(
                'Des souvenirs que vous pouvez toucher.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ],
          ),
        ),
        toolbarHeight: 144,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Quel est ton prénom ?',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Quel est ton adresse mail ?',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Choisis ton mot de passe ?',
              ),
            ),
            const SizedBox(height: 48),
            ButtonWidget(
              label: 'Continuer',
              variant: ButtonVariant.primary,
              size: ButtonSize.big,
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 20),
            Text('ou'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Logique pour se connecter avec Google
              },
              icon: const Icon(Icons.login),
              label: const Text('Se connecter avec Google'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Logique pour se connecter avec Apple
              },
              icon: const Icon(Icons.apple),
              label: const Text('Se connecter avec Apple'),
            ),
          ],
        ),
      ),
    );
  }
}
