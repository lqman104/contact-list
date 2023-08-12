import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

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
            foregroundImage: Image.network(
              "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/484.jpg",
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
            ).image,
          ),
        ),
        title: const Text("Luqman Hakim"),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("krisna nugroho"),
            Text("lqman104@gmail.com"),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red.shade300,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
