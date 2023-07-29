import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gro_better/model/user.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/services/database/database.dart';
import 'package:gro_better/shared/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromCredential(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get userlog {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromCredential(user));
  }

  //Google Sign In
  SignInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Future SignInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromCredential(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email & password
  Future signEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      currentuserId = user!.uid;
      return _userFromCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future deleteAccount(String email, String password) async {
    try {
      User user = await FirebaseAuth.instance.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      UserCredential result =
          await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user!.uid)
          .deleteUserRecords(); // called from database class
      await result.user!.delete();
      return true;
    } catch (e) {
      print('Error deleting account $e');
      return null;
    }
  }

  //sign out

  Future Logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with phone number

  //register with email&password
  Future registerWithEmailAndPassword(
      String name, String email, String password, DateTime dob) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      UserDetails userDetails = UserDetails(
        uid: user!.uid,
        name: name,
        email: email,
        dob: dob,
      );
      // create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData(userDetails);
      return _userFromCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
