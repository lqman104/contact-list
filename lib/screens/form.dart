import 'package:contactlist/components/form_container.dart';
import 'package:flutter/material.dart';

import '../contants/styles.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            value: 'male',
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
