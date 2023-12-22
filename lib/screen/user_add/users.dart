import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/screen/user_add/users_provider.dart';
import 'package:users/screen/user_information/user_information.dart';

import '../../custom_widget/custom_widgets.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final userProvider = UsersProvider();

  @override
  void deactivate() {
    setState(() {
      userProvider.userNameController.text = '';
      userProvider.userEmailController.text = '';
      userProvider.userEnrollNumberController.text = '';
      userProvider.userAddressController.text = '';
    });
    super.deactivate();
  }

  @override
  void dispose() {
    userProvider.userNameController.clear();
    userProvider.userEmailController.clear();
    userProvider.userEnrollNumberController.clear();
    userProvider.userAddressController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: (){
            setState(() {
              FocusScope.of(context).unfocus();
            });
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: CustomWidget.commonText(
                  commonText: "Hello User",
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Form(
                      key: provider.userFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: CustomWidget.commonTextFormField(
                                context: context,
                                hintText: "Name",
                                textFieldController: provider.userNameController,
                                allowValidation: true,
                                focusNode: provider.userNameNode,
                                errorMessage: "Enter Name",
                                onFieldSubmitted: (val) {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(provider.userEmailNode);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: CustomWidget.commonTextFormField(
                                context: context,
                                hintText: "Email",
                                errorMessage: "Enter Email",
                                textFieldController: provider.userEmailController,
                                allowValidation: true,
                                focusNode: provider.userEmailNode,
                                onFieldSubmitted: (val) {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(
                                        provider.userEnrollNumberNode);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: CustomWidget.commonTextFormField(
                                context: context,
                                hintText: "Enroll Number",
                                errorMessage: "Enter Enroll Number",
                                keyboardType: TextInputType.number,
                                length: 10,
                                textFieldController:
                                    provider.userEnrollNumberController,
                                allowValidation: true,
                                focusNode: provider.userEnrollNumberNode,
                                onFieldSubmitted: (val) {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(provider.userAddressNode);
                                  });
                                }),
                          ),
                          CustomWidget.commonTextFormField(
                              context: context,
                              hintText: "address",
                              errorMessage: "Enter Address",
                              length: 10,
                              textFieldController: provider.userAddressController,
                              allowValidation: true,
                              focusNode: provider.userAddressNode,
                              onFieldSubmitted: (val) {
                                setState(() {
                                  FocusScope.of(context).requestFocus(
                                      provider.userSubmitInformationNode);
                                });
                              }),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: CustomWidget.commonElevatedButton(
                                focusNode: provider.userSubmitInformationNode,
                                onFocusChange: (val) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                onTap: () {
                                  provider.addUserData(context: context).then((value) {
                                    if(provider.userFormKey.currentState!.validate()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (
                                                context) => const UserInformation(),
                                          )).then((value) =>
                                          setState(() {
                                            provider.userFormKey.currentState!
                                                .reset();
                                            provider.userNameController.text =
                                            '';
                                            provider.userEmailController.text =
                                            '';
                                            provider.userEnrollNumberController
                                                .text = '';
                                            provider.userAddressController
                                                .text = '';
                                            FocusScope.of(context).unfocus();
                                          }));
                                    }
                                    provider.userFormKey.currentState!.reset();
                                    provider.userNameController.clear();
                                    provider.userEmailController.clear();
                                    provider.userEnrollNumberController.clear();
                                    provider.userAddressController.clear();
                                    provider.notifyListeners();
                                  });
                                },
                                context: context,
                                buttonText: 'Submit'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: CustomWidget.commonElevatedButton(
                                onFocusChange: (val) {
                                  FocusScope.of(context).unfocus();
                                },
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const UserInformation(),
                                    )).then((value) => setState((){}));
                                    // provider.getUserData();
                                    provider.getAllData();
                                  });
                                },
                                context: context,
                                buttonText: 'Show List'),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
