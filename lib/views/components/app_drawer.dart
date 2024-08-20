import 'package:flutter/material.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageCacheHelper.avatarImage(
                      url:
                          "https://images.pexels.com/photos/1391499/pexels-photo-1391499.jpeg?cs=srgb&dl=pexels-soldiervip-1391499.jpg&fm=jpg",
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15),
                  Text("User name")
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: const ListTile(
              title: Text("Home"),
              leading: Text("data"),
            ),
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Text("Friend $index"),
                      leading: Text("data"),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    DividerHelper.sizedboxDivider(),
                itemCount: 10),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.transparent.withOpacity(0)),
              child: const ListTile(
                title: Text(
                  "Sign out",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
                leading: Icon(
                  Icons.logout_sharp,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
