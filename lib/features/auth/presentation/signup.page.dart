import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/input.widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
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
                    height: 1.2,
                  ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
        toolbarHeight: 144,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                spacing: 48,
                children: [
                  Column(
                    spacing: 24,
                    children: [
                      InputWidget(
                        label: 'Quel est ton prénom ?',
                        placeholder: 'John',
                      ),
                      InputWidget(
                        label: 'Quel est ton adresse mail ?',
                        placeholder: 'john.doe@gmail.com',
                      ),
                      InputWidget(
                        label: 'Choisis ton mot de passe ?',
                        placeholder: 'Mot de passe',
                        obscureText: true,
                      ),
                    ],
                  ),
                  ButtonWidget(
                    label: 'Continuer',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.big,
                    onPressed: () {},
                    fullWidth: true,
                  ),
                ],
              ),

              // ou separator
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   spacing: 8,
              //   children: [
              //     Container(
              //       height: 2,
              //       width: 130,
              //       color: Theme.of(context).colorScheme.outline,
              //     ),
              //     Text('ou'),
              //     Container(
              //       height: 1,
              //       width: 130,
              //       color: Theme.of(context).colorScheme.outline,
              //     ),
              //   ],
              // ),

              // conexion with Google and Apple
            ],
          ),
        ),
      ),
    );
  }
}
