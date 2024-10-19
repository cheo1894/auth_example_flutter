import 'package:auth_flutter_example/services/connection_service.dart';


Future test(String text) async {
  await ConnectionService().test().then((value) {
    text = value;
  });
}
