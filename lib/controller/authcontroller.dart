import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redlenshoescleaning/model/usermodel.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Inisialisasi Firebase Authentication
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  bool get success => false;

  /// Fungsi registrasi pengguna melalui email dan password
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      /// Mencoba membuat pengguna baru menggunakan Firebase Authentication
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        /// Jika berhasil, membuat objek UserModel dan menyimpannya di Firestore
        final UserModel newUser = UserModel(
            name: name, email: user.email ?? '', uId: user.uid, role: 'user');

        await userCollection.doc(newUser.uId).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      //
    }
    return null;
  }

  /// Fungsi login pengguna melalui email dan password
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      /// Mencoba proses login menggunakan Firebase Authentication
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        /// Jika login berhasil, mengambil data pengguna dari Firestore
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        /// Membuat objek UserModel berdasarkan data pengguna yang diambil
        final UserModel currentUser = UserModel(
          uId: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
          role: snapshot['role'] ?? '',
        );

        return currentUser;
      }
    } catch (e) {
      //
    }
    return null;
  }

  /// Mendapatkan pengguna yang saat ini masuk
  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
