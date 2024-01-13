import 'package:firebase_database/firebase_database.dart';

class FirebaseServices {
  static Future<Map?> getData(DatabaseReference reference) async {
    Map? allData;

    await reference.get().then(
      (value) {
        allData = value.value == null ? null : value.value as Map;
      },
    );
    return allData;
  }
}
