import 'package:flutter/material.dart';

class AddContactFloatingButton extends StatelessWidget {
  const AddContactFloatingButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.person_add),
    );
  }
}
