import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? person;
  final String size;

  const AvatarWidget({super.key, this.person, required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      radius: size == 'small'
          ? 8
          : size == 'medium'
              ? 16
              : 25,
      child: person == null
          ? Icon(
              Icons.person,
              size: size == 'small'
                  ? 12
                  : size == 'medium'
                      ? 24
                      : 40,
              color: Theme.of(context).colorScheme.outline,
            )
          : CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/$person.png'),
              radius: size == 'small'
                  ? 8
                  : size == 'medium'
                      ? 15
                      : 24,
            ),
    );
  }
}
