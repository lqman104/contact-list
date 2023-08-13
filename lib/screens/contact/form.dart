import 'dart:io';

import 'package:contactlist/components/form_container.dart';
import 'package:contactlist/screens/contact/contact_provider.dart';
import 'package:contactlist/screens/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../contants/styles.dart';
import '../../models/data_response.dart';
import '../../util/ui_util.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ImageProvider? getAvatar(String path) {
      if(path.isNotEmpty) {
        return Image.file(File(path)).image;
      }

      return null;
    }

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
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          _onImageButtonPressed(context);
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            radius: 30,
                            foregroundImage: getAvatar(context.watch<ContactProvider>().photoPath),
                            child: const Icon(Icons.camera_alt_outlined, color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<ContactProvider>().username = value;
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
                        context.read<ContactProvider>().lastName = value;
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
                        Icon(
                          Icons.male,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: context.watch<ContactProvider>().gender,
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            onChanged: (String? value) {
                              context.read<ContactProvider>().setGender(value ?? "male");
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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        context.read<ContactProvider>().email = value;
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
                  DataResponse response = await context.read<ContactProvider>()
                      .save();

                  if (!context.mounted) return;

                  if (response is Success) {
                    context.read<ContactProvider>().refresh();
                    context.read<ScreenProvider>().setSelectedIndex(0);
                  } else if (response is Failed) {
                    showMySnackbar(context, response.message);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onImageButtonPressed(
    BuildContext context,
  ) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? media = await picker.pickImage(source: ImageSource.camera);
      if (!context.mounted) {
        return;
      }
      if (media != null) {
        context.read<ContactProvider>().setPhotoPath(media.path);
      }
    } catch (e) {
      showMySnackbar(context, e.toString());
    }
  }
}
