import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myapp/widgets/loading_widget.dart';
import 'package:myapp/database/app_database.dart';
import 'package:myapp/models/contact.dart';

class AddContactBottomSheet extends StatefulHookWidget {
  final Contact? contact;
  const AddContactBottomSheet({super.key, this.contact});

  @override
  State<StatefulWidget> createState() => _AddContactBottomSheetState();
}

class _AddContactBottomSheetState extends State<AddContactBottomSheet> {
  final formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic>? get formData => formKey.currentState?.value;

  final AppDatabase db = AppDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);

    final contact = useState<Contact?>(widget.contact);

    void onSubmit() {
      if (formKey.currentState?.validate() == true) {
        isLoading.value = true;
        formKey.currentState?.save();
      }

      final newContact = Contact.fromJson(formData!);

      if (widget.contact == null) {
        db.createContact(newContact);
      } else {
        db.updateContact(newContact.copyWith(id: widget.contact!.id!));
      }

      isLoading.value = false;
      Navigator.pop(context, true);
    }

    if (isLoading.value) {
      return const LoadingWidget();
    }

    return Padding(
      padding: MediaQuery.viewInsetsOf(context),
      child: FormBuilder(
        key: formKey,
        enabled: !isLoading.value,
        initialValue: {
          idField: contact.value?.id,
          firstNameField: contact.value?.firstName,
          lastNameField: contact.value?.lastName,
          phoneNumberField: contact.value?.phoneNumber,
          emailField: contact.value?.email,
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: firstNameField,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              FormBuilderTextField(
                name: lastNameField,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: phoneNumberField,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: emailField,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: FormBuilderValidators.email(checkNullOrEmpty: false),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onSubmit,
                child: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
