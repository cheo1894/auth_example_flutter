import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectionService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future test() async {
    var response = await firestore.collection('connection_test').doc('test').get();

    print('response >>>> ${response.data()!['text']}');

    return response.data()!['text'];
  }
}
