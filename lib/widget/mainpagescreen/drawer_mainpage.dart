import 'package:flutter/material.dart';

class DrawerMainPage extends StatelessWidget {
  const DrawerMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 255.0,
        color: Colors.white10,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration:const BoxDecoration(
                color:Colors.white10,
              ),
              accountName: const Text(
                "UserAccount",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: "Brand-Bold"),
              ),
              accountEmail: const Text(
                "UserEmail",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: "Brand-Bold"),
              ),
              currentAccountPicture: Image.asset(
                "assets/images/user_icon.png",
                width: 70.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height:12.0,),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.history,size:30,color:Colors.black,),
              title: const Text(
                "History",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: "Brand-Bold"),
              ),
            ),
            const SizedBox(height:12.0,),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.person,size:30,color:Colors.black,),
              title: const Text(
                "Visit Profile",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: "Brand-Bold"),
              ),
            ),
            const SizedBox(height:12.0,),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.info,size:30,color:Colors.black,),
              title: const Text(
                "About",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontFamily: "Brand-Bold"),
              ),
            ),


          ],
        ),
    );
  }
}
