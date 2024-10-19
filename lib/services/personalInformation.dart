import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInformation {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future setPersonalInformation(
      {required String firstName, required String lastName, required int age}) async {
    try {
      var response = firestore.collection('personal_information').doc();

      Map<String, dynamic> data = {"firstName": firstName, "lastName": lastName, "age": age};

      await response.set(data);
      return 1;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
