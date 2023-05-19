import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:api_loacaldb_getx/services/api_service.dart';
import 'package:api_loacaldb_getx/models/user.dart';
import 'package:api_loacaldb_getx/controllers/view_state_ctrl.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User>? user = [];
  final viewCtrl = Get.put(ViewStateCtrl());

  @override
  void initState() {
    super.initState();
    _userData();
  }

  void _userData() async {
    user = await ApiService().getUsers();
    if (user != null) {
      setState(() {
        viewCtrl.changeVisb();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Visibility(
        visible: viewCtrl.visb.value,
        replacement: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Loading Users..."),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator.adaptive(),
              ]),
        ),
        child: ListView.builder(
          itemCount: user!.length,
          itemBuilder: (BuildContext context, int ind) {
            return Container(
              margin: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
              padding: const EdgeInsets.only(top: 15, right: 15),
              height: 200,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 245, 241, 241),
                      spreadRadius: 1.5,
                      blurRadius: 5,
                      offset: Offset(0, 2))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Regular profile picture
                    // Image.asset(
                    //   "images/profile.jpg",
                    //   width: 100,
                    //   height: 70,
                    // ),
                    // Circular profile
                    const CircleAvatar(
                      backgroundImage: AssetImage("images/profile.jpg"),
                      radius: 70,
                    ),

                    // name info, address, view button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (user![ind].name).toUpperCase(),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 35, 165, 135)),
                        ),
                        Text(
                          '@${(user![ind].username).toLowerCase()}',
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: Text(
                            user![ind].email,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          child: Text(
                            user![ind].phone,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // do nothing for now
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 33, 182, 147)),
                          child: const Text("Delete User"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Website: ${user![ind].website}",
                          style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Suite: ${user![ind].address.suite}",
                          style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),

                    // line break
                    const VerticalDivider(
                      endIndent: 10,
                    ),

                    // companyInfo, address, socialMedia & geoLocation
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // #1 geo location
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                color: Color.fromARGB(255, 35, 165, 135),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "LAT: ${user![ind].address.geo.lat}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    "LONG: ${user![ind].address.geo.lng}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          // #2 company
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Company",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Name: ${user![ind].company.name}",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                user![ind].company.catchPhrase,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "bs: ${user![ind].company.bs}",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          // #3 address
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Street: ${user![ind].address.street}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "City: ${user![ind].address.city}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300),
                                ),
                              ]),
                          const SizedBox(
                            height: 8,
                          ),

                          // #4 social media
                          Row(children: const [
                            Icon(
                              Icons.facebook,
                              color: Color.fromARGB(255, 35, 165, 135),
                              size: 18,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.whatshot_sharp,
                              color: Color.fromARGB(255, 35, 165, 135),
                              size: 18,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.tiktok,
                              color: Color.fromARGB(255, 35, 165, 135),
                              size: 18,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.snapchat,
                              color: Color.fromARGB(255, 35, 165, 135),
                              size: 18,
                            ),
                          ])
                        ]),
                  ]),
            );
          },
        ),
      ),
    ));
  }
}
