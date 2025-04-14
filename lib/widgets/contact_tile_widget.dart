// Suggested code may be subject to a license. Learn more: ~LicenseLog:666328942.
import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactTileWidget extends StatelessWidget {
  final Contact contact;

  final Function()? onEdit;
  final Function() onDelete;

  const ContactTileWidget({super.key, required this.contact, this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(contact.id),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: InkWell(
        onTap: onEdit,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              "${contact.firstName?.substring(0, 1) ?? ''}${contact.lastName?.substring(0, 1) ?? ''}",
            ),
          ),
          title: Text("${contact.firstName ?? ''} ${contact.lastName ?? ''}"),
          subtitle: Text(contact.phoneNumber ?? ''),
        ),
      ),
    );
  }
}
