import 'package:flutter/material.dart';

import '../../../core/ui/responsive.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);

    return NavigationDrawer(
      onDestinationSelected: (index) {
        if (index == 0) {
          if (!isDesktop) Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/config');
        }
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
          child: Text(
            'Opções',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text('Configurações'),
        ),
      ],
    );
  }
}
