import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:users/custom_widget/custom_widgets.dart';
import 'package:users/screen/user_add/users.dart';
import 'package:users/screen/user_add/users_provider.dart';

import '../edit_user/edit_user.dart';
import 'on_click_user_information/on_click_user_information.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final usersProvider = UsersProvider();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(CupertinoIcons.back, color: Colors.black),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => const Users(),
                  // ));
                  Navigator.of(context).pop();
                }),
            actions: [
              userProvider.userDataList.isNotEmpty?IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: CustomWidget.commonText(
                                    commonText: 'Yes',
                                    textOnTap: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                        userProvider.deleteAllDataFromSqlTable();
                                      });
                                    },
                                    color: Colors.black)),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).pop();
                                    print("TAPPED");
                                  });
                                },
                                child: CustomWidget.commonText(
                                    textOnTap: () {
                                      setState(() {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    commonText: 'No',
                                    color: Colors.black))
                          ],
                          title: CustomWidget.commonText(
                              commonText:
                                  'Are you sure you want to delete All Data ?'),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.delete,
                    color: Colors.black,
                  )):const SizedBox()
            ],
            automaticallyImplyLeading: false,
            title: CustomWidget.commonText(
                commonText: "User Information",
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
          body: Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () => userProvider.getUserData(),
                child: userProvider.userDataList.isEmpty
                    ? Center(
                        child: CustomWidget.commonText(
                            commonText: "User Data List Is Empty",
                            color: Colors.red),
                      )
                    : ListView.builder(
                        itemCount: userProvider.userDataList.length,
                        padding: const EdgeInsets.all(15),
                        itemBuilder: (context, index) {
                          final id = userProvider.userDataList[index]['_id'];
                          final name = userProvider.userDataList[index]['name'];
                          final email =
                              userProvider.userDataList[index]['email'];
                          final enroll =
                              userProvider.userDataList[index]['enrollNumber'];
                          final address =
                              userProvider.userDataList[index]['address'];
                          return userProvider.userDataList.isEmpty
                              ? Center(
                                  child: CustomWidget.commonText(
                                      commonText: "User Data Is Empty",
                                      fontSize: 30,
                                      color: Colors.black),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => UserDetails(
                                          id: id,
                                          address: address,
                                          email: email,
                                          enroll: enroll,
                                          name: name,
                                        ),
                                      ));
                                    },
                                    child: Slidable(
                                      key: const ValueKey(0),
                                      startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.25,
                                          children: [
                                            SlidableAction(
                                              autoClose: true,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                              icon: Icons.edit,
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color(0xff33bac4),
                                              onPressed: (context) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserEdit(
                                                          id: id,
                                                          name: name,
                                                          email: email,
                                                          address: address,
                                                          enroll: enroll),
                                                ));
                                              },
                                            )
                                          ]),
                                      endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.25,
                                          children: [
                                            SlidableAction(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                              backgroundColor:
                                                  const Color(0xff33bac4),
                                              onPressed: (context) {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                userProvider
                                                                    .deleteUser(
                                                                        id);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            },
                                                            child: CustomWidget
                                                                .commonText(
                                                                    commonText:
                                                                        'Yes',
                                                                    textOnTap:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        userProvider
                                                                            .deleteUser(id);
                                                                      });
                                                                    },
                                                                    color: Colors
                                                                        .black)),
                                                        TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                print("TAPPED");
                                                              });
                                                            },
                                                            child: CustomWidget
                                                                .commonText(
                                                                    textOnTap:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      });
                                                                    },
                                                                    commonText:
                                                                        'No',
                                                                    color: Colors
                                                                        .black))
                                                      ],
                                                      title: CustomWidget
                                                          .commonText(
                                                              commonText:
                                                                  'Are you sure you want to delete ?'),
                                                    );
                                                  },
                                                );
                                              },
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                            )
                                          ]),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey),
                                        child: CustomWidget.commonText(
                                            commonText: 'Name : $name',
                                            textOnTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetails(
                                                  id: id,
                                                  address: address,
                                                  email: email,
                                                  enroll: enroll,
                                                  name: name,
                                                ),
                                              ));
                                            },
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
              ))
            ],
          ),
        );
      },
    );
  }
}
