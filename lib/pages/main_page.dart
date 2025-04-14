import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myapp/widgets/add_contact_bottom_sheet.dart';
import 'package:myapp/widgets/add_contact_floating_button.dart';
import 'package:myapp/widgets/contact_tile_widget.dart';
import 'package:myapp/widgets/empty_contact_widget.dart';
import 'package:myapp/widgets/loading_widget.dart';
import 'package:myapp/database/app_database.dart';
import 'package:myapp/models/contact.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDatabase db = AppDatabase.instance;

    final contacts = useState<List<Contact>>([]);
    final isLoading = useState<bool>(false);

    late Widget body;

    Future refreshContacts() async {
      isLoading.value = true;
      contacts.value = await db.readAllContacts();
      isLoading.value = false;
    }

    useEffect(() {
      refreshContacts();
      return () => db.close();
    }, const []);

    Future<bool?> showAddContactBottomSheet(BuildContext context,
        {Contact? contact}) {
      return showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(),
        builder: (context) => AddContactBottomSheet(contact: contact),
      );
    }

    if (isLoading.value) {
      body = const LoadingWidget();
    }

    if (contacts.value.isEmpty) {
      body = const EmptyContactWidget();
    }

    if (contacts.value.isNotEmpty && !isLoading.value) {
      body = ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.value.length,
        separatorBuilder: (context, i) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final contact = contacts.value[i];
          return ContactTileWidget(
            contact: contact,
            onDelete: () => db.deleteContact(contact.id!).then((_) => refreshContacts()),
            onEdit: () => showAddContactBottomSheet(context, contact: contact)
                .then((_) => refreshContacts()),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("PPB Phonebook")),
      body: body,
      floatingActionButton: AddContactFloatingButton(
        onPressed: () =>
            showAddContactBottomSheet(context).then((_) => refreshContacts()),
      ),
    );
  }
}
