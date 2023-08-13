import 'package:contactlist/components/form_container.dart';
import 'package:contactlist/screens/contact/contact_provider.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../contants/styles.dart';
import '../../models/data_response.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String lastName = "";
    String gender = "male";
    String email = "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FormContainer(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: Styles.getIconInputDecoration(
                        hint: 'Firstname',
                        iconData: Icons.person_outline,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        lastName = value;
                      },
                      decoration: Styles.getIconInputDecoration(
                        hint: 'Lastname',
                        iconData: Icons.person_outline,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        Icon(Icons.male, color: Colors.grey.shade300,),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: gender,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              gender = value ?? "male";
                            },
                            items: ['male', 'female']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: Styles.getIconInputDecoration(
                        hint: 'Email',
                        iconData: Icons.email_outlined,
                      ),
                    ),
                  ),
                ],
              ),
              FilledButton(
                child: const Text('Save'),
                onPressed: () async {
                  DataResponse response = await context
                      .read<ContactProvider>()
                      .save(username: username, lastName: lastName, gender: gender, email: email);

                  if (!context.mounted) return;

                  if (response is Success) {
                    context.read<ContactProvider>().refresh();
                    context.read<ScreenProvider>().setSelectedIndex(0);
                  } else if (response is Failed) {
                    showSnackbar(context, response.message);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
