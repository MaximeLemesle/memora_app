import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memora_app/core/widgets/button.widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/landing-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // invisible box
              SizedBox(height: 24),

              // Logo and baseline
              Column(
                spacing: 16,
                children: [
                  SvgPicture.asset(
                    'assets/logos/logo-light-h.svg',
                    width: 300,
                    height: 60,
                  ),
                  Text(
                    'Des souvenirs que vous pouvez toucher.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                  ),
                ],
              ),

              // Inscription / Connexion
              Column(
                spacing: 32,
                children: [
                  ButtonWidget(
                    label: 'Créer un compte',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.big,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup_page');
                    },
                    fullWidth: true,
                  ),
                  Column(
                    children: [
                      Text('Déjà membre ?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              )),
                      ButtonWidget(
                        label: 'Se connecter',
                        variant: ButtonVariant.ghost,
                        size: ButtonSize.big,
                        onPressed: () {
                          Navigator.pushNamed(context, '/login_page');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
