import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users/custom_widget/custom_widgets.dart';
import 'package:users/screen/user_information/user_information.dart';

class UserDetails extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String enroll;
  final String address;

  UserDetails(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.enroll,
      required this.address});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(CupertinoIcons.back,color: Colors.black),
            onPressed: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const UserInformation(),
                // ));
                Navigator.of(context).pop();

            }),
        title: CustomWidget.commonText(
            commonText: "User Details", fontSize: 30, fontWeight: FontWeight.w600,color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              child: CustomWidget.commonText(
                commonText: "User Details",
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            CustomWidget.commonText(
              commonText: "User ID :  ${widget.id}",
              fontSize: 20,
            ),
            const SizedBox(
              height: 3,
            ),
            CustomWidget.commonText(
              commonText: "Name :  ${widget.name}",
              fontSize: 20,
            ),
            const SizedBox(
              height: 3,
            ),
            CustomWidget.commonText(
              commonText: "Email :  ${widget.email}",
              fontSize: 20,
            ),
            const SizedBox(
              height: 3,
            ),
            CustomWidget.commonText(
              commonText: "Enroll Number :  ${widget.enroll}",
              fontSize: 20,
            ),
            const SizedBox(
              height: 3,
            ),
            CustomWidget.commonText(
              commonText: "Address :  ${widget.address}",
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
