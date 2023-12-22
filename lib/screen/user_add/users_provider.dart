import 'package:flutter/material.dart';
import 'package:users/database_helper/database_helper.dart';

import '../user_information/user_information.dart';

class UsersProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userEnrollNumberController = TextEditingController();
  TextEditingController userAddressController = TextEditingController();
  FocusNode userNameNode = FocusNode();
  FocusNode userEmailNode = FocusNode();
  FocusNode userEnrollNumberNode = FocusNode();
  FocusNode userAddressNode = FocusNode();
  FocusNode userSubmitInformationNode = FocusNode();
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> userDataList = [];
  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  Future addUserData({required BuildContext context}) async {
    try {
      if (userFormKey.currentState!.validate()) {
        final database = await dbHelper.getDatabase();
        await database.insert(dbHelper.tableName, {
          dbHelper.userName: userNameController.text.trim(),
          dbHelper.userEmail: userEmailController.text.toLowerCase().trim(),
          dbHelper.userEnrollNumber: userEnrollNumberController.text.trim(),
          dbHelper.userAddress: userAddressController.text.trim(),
        });

        userAddressNode.unfocus();
        getUserData();
        notifyListeners();
      }
    } catch (e) {
      print("ERROR IN ADD USER ::> $e");
    }
  }

  Future<void> getAllData()async{
    final database = await dbHelper.getDatabase();
    List<Map> maps =
    await database.rawQuery('SELECT * FROM sqlite_master ORDER BY ${dbHelper.userName}');
    print("All Table $maps");

  }

  // void addUserData() async {
  //   try {
  //     if (userFormKey.currentState!.validate()) {
  //       final database = await dbHelper.getDatabase();
  //       await database.insert(dbHelper.tableName, {
  //         dbHelper.userName: userNameController.text.trim(),
  //         dbHelper.userEmail: userEmailController.text.toLowerCase().trim(),
  //         dbHelper.userEnrollNumber: userEnrollNumberController.text.trim(),
  //         dbHelper.userAddress: userAddressController.text.trim(),
  //       });
  //       userNameController.clear();
  //       userEmailController.clear();
  //       userEnrollNumberController.clear();
  //       userAddressController.clear();
  //     }
  //   } catch (e) {
  //     print("ERROR IN ADD USER ::> $e");
  //   } finally {
  //     userFormKey.currentState!.reset();
  //     userAddressNode.unfocus();
  //     getUserData();
  //     // Navigator.of(context).push(MaterialPageRoute(
  //     //   builder: (context) => const UserInformation(),
  //     // ));
  //     notifyListeners();
  //   }
  // }

  Future<void> getUserData() async {
    try {
      final database = await dbHelper.getDatabase();
      userDataList = await database.query(dbHelper.tableName);
      notifyListeners();
      print('User Data List: $userDataList');
    } catch (e) {
      print("Error in fetching userdata: $e");
    }
    notifyListeners();
  }
  Future<void> deleteAllDataFromSqlTable()async{
    final database = await dbHelper.getDatabase();
    database.rawDelete("DELETE FROM ${dbHelper.tableName}");
    print("Delete Perform");
    getUserData();
    notifyListeners();
  }


  Future<void> deleteUser(int userId) async {
    final database = await dbHelper.getDatabase();
    await database.delete(
      dbHelper.tableName,
      where: '${dbHelper.userId} = ?',
      whereArgs: [userId],
    );
    getUserData();
    notifyListeners();
  }

// Future<void> updateUserData(
//     {required int userId,
//     required BuildContext context,
//     required String name,
//     required String email,
//     required String enroll,
//     required String address}) async {
//   if (userFormKey.currentState!.validate()) {
//     final database = await dbHelper.getDatabase();
//     await database.update(
//       dbHelper.tableName,
//       {
//         dbHelper.userName: name,
//         dbHelper.userEmail: email,
//         dbHelper.userEnrollNumber: enroll,
//         dbHelper.userAddress: address,
//       },
//       where: '${dbHelper.userId} = ?',
//       whereArgs: [userId],
//     );
//     // await database.close();
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => const UserInformation(),
//     ));
//     notifyListeners();
//   }
// }
}
