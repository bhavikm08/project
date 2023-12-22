import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/custom_widget/custom_widgets.dart';
import 'package:users/screen/user_add/users_provider.dart';

import '../../database_helper/database_helper.dart';
import '../user_information/user_information.dart';

class UserEdit extends StatefulWidget {
  final int id;
  final String name;
  final String email;
  final String enroll;
  final String address;

  UserEdit(
      {super.key,
      required this.id,
      required this.name,
      required this.email,
      required this.enroll,
      required this.address});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  GlobalKey<FormState> editUserFormKey = GlobalKey<FormState>();
  TextEditingController editUserNameController = TextEditingController();
  TextEditingController editUserEmailController = TextEditingController();
  TextEditingController editUserEnrollNumberController = TextEditingController();
  TextEditingController editUserAddressController = TextEditingController();
  FocusNode editUserNameNode = FocusNode();
  FocusNode editUserEmailNode = FocusNode();
  FocusNode editUserEnrollNumberNode = FocusNode();
  FocusNode editUserAddressNode = FocusNode();
  FocusNode editUserSubmitInformationNode = FocusNode();
  final dbHelper = DatabaseHelper.instance;
  final userProvider = UsersProvider();

  Future<void> updateUserData() async {
    if (editUserFormKey.currentState!.validate()) {
      final database = await dbHelper.getDatabase();
      await database.update(
        dbHelper.tableName,
        {
          dbHelper.userName: editUserNameController.text.trim(),
          dbHelper.userEmail: editUserEmailController.text.toLowerCase(),
          dbHelper.userEnrollNumber: editUserEnrollNumberController.text.trim(),
          dbHelper.userAddress: editUserAddressController.text.trim(),
        },
        where: '${dbHelper.userId} = ?',
        whereArgs: [widget.id],
      );
      // await database.close();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const UserInformation(),
      ));
    }
  }

  @override
  void initState() {
    print("Id : ${widget.id}");
    print("Name : ${widget.name}");
    print("Email : ${widget.email}");
    print("Enroll : ${widget.enroll}");
    print("Address : ${widget.address}");
    super.initState();
    editUserNameController = TextEditingController(text: widget.name);
    editUserEmailController = TextEditingController(text: widget.email);
    editUserEnrollNumberController = TextEditingController(text: widget.enroll);
    editUserAddressController = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const UserInformation(),));
        }, icon: const Icon(CupertinoIcons.back)),
            title: CustomWidget.commonText(commonText: 'Edit User'),
          ),
          body: Form(
              key: editUserFormKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: CustomWidget.commonTextFormField(
                        context: context,
                        labelText: "Name",
                        textFieldController: editUserNameController,
                        allowValidation: true,
                        focusNode: editUserNameNode,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(editUserEmailNode);
                          print('Email ${editUserEmailController.text.trim()}');
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: CustomWidget.commonTextFormField(
                        context: context,
                        labelText: "Email",
                        textFieldController: editUserEmailController,
                        allowValidation: true,
                        focusNode: editUserEmailNode,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(editUserEnrollNumberNode);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: CustomWidget.commonTextFormField(
                        context: context,
                        labelText: "Enroll Number",
                        keyboardType: TextInputType.number,
                        textFieldController: editUserEnrollNumberController,
                        allowValidation: true,
                        focusNode: editUserEnrollNumberNode,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(editUserAddressNode);
                        }),
                  ),
                  CustomWidget.commonTextFormField(
                      context: context,
                      labelText: "address",
                      textFieldController: editUserAddressController,
                      allowValidation: true,
                      focusNode: editUserAddressNode,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context)
                            .requestFocus(editUserSubmitInformationNode);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: CustomWidget.commonElevatedButton(
                        onFocusChange: (val) {
                          FocusScope.of(context).unfocus();
                        },
                        onTap: () async{
                          if (editUserFormKey.currentState!.validate()) {
                            final database = await dbHelper.getDatabase();
                            await database.update(
                              dbHelper.tableName,
                              {
                                dbHelper.userName: editUserNameController.text.trim(),
                                dbHelper.userEmail: editUserEmailController.text.toLowerCase(),
                                dbHelper.userEnrollNumber: editUserEnrollNumberController.text.trim(),
                                dbHelper.userAddress: editUserAddressController.text.trim(),
                              },
                              where: '${dbHelper.userId} = ?',
                              whereArgs: [widget.id],
                            );
                            // await database.close();
                            provider.getUserData();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const UserInformation(),
                            ));
                          }

                          // updateUserData();
                          // provider.updateUserData(
                          //     context: context,
                          //     userId: widget.id,
                          //     name: editUserNameController.text.trim(),
                          //     email: editUserEmailController.text.toLowerCase(),
                          //     enroll:
                          //         editUserEnrollNumberController.text.trim(),
                          //     address: editUserAddressController.text.trim());
                        },
                        context: context,
                        buttonText: 'Update'),
                  ),
                ],
              )),
        );
      },
    );
  }
}
