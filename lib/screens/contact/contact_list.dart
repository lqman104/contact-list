import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/screens/contact/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../components/search_form_field.dart';
import '../../components/user_tile.dart';
import '../../util/ui_util.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  Widget noDataWidget() {
    return const Center(
      child: Text("No data"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<ContactProvider>().isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // search
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: SearchFormField(
              onChange: (value) {
                context.read<ContactProvider>().search(value);
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: FutureBuilder<DataResponse>(
              initialData: Success([]),
              future: context.read<ContactProvider>().fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is Success) {
                    List<dynamic> contact = (snapshot.data as Success).data;

                    if (contact.isEmpty) {
                      return noDataWidget();
                    }

                    return ListView.builder(
                      itemCount: contact.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: UserTile(
                              contact: contact[index],
                              onClickAction: () async {
                                DataResponse response = await context
                                    .read<ContactProvider>()
                                    .delete(contact[index].id);

                                if (!context.mounted) return;

                                if (response is Success) {
                                  context.read<ContactProvider>().refresh();
                                } else if (response is Failed) {
                                  showMySnackbar(context, response.message);
                                }
                              }),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text((snapshot.data as Failed).message),
                    );
                  }
                } else {
                  return noDataWidget();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
