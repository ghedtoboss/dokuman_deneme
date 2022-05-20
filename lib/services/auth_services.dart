import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //çıkış yap fonk
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt olma/etme butonu
  Future<User?> createPerson(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (user.user != null) {
      await _firestore
          .collection("Çalışanlar")
          .doc(user.user!.uid)
          .set({"Ad soyad": name, "email": email, 'şifre': password});
    }

    return user.user;
  }
}
