import 'package:flutter/material.dart';

class EmptyContactWidget extends StatelessWidget {
  const EmptyContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.person_off,
            size: 100,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 20),
          Text(
            'No contacts available',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
          ),
        ],
      ),
    );
  }
}
