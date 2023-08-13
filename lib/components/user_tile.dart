import 'dart:io';

import 'package:contactlist/models/contact.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final Contact contact;
  final Function() onClickAction;

  const UserTile({
    super.key,
    required this.contact,
    required this.onClickAction,
  });

  ImageProvider getAvatar(String path) {
    final bool isUrl = (path.contains("http://") ||path.contains("https://"));
    if(isUrl) {
      return Image.network(
        contact.avatar,
        errorBuilder: (context, object, stackTrace) {
          return Container(
            color: Colors.red,
            child: null,
          );
        },
        loadingBuilder: (context, widget, isLoading) {
          if (isLoading == null) {
            return widget;
          }
          return Container(
            color: Colors.grey.shade700,
            child: null,
          );
        },
      ).image;
    } else {
      return Image.file(File(path)).image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: CircleAvatar(
            radius: 30,
            foregroundImage: getAvatar(contact.avatar),
          ),
        ),
        title: Text(contact.username),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.lastName),
            Text(contact.email),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red.shade300,
          ),
          onPressed: onClickAction,
        ),
      ),
    );
  }
}
