// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:gro_better/services/auth.dart';
// import 'package:gro_better/services/database/database.dart';
// import 'package:gro_better/shared/constants.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfileProvider with ChangeNotifier {
//   final AuthService _auth = AuthService();
//   DatabaseService db = DatabaseService(uid: currentuserId);
//   bool loading = false;
//   File? _photo;
//   File? get photo => _photo;
//   String error = '';
//   String photoUrl = '';
//   String bioNotes = '';
//   String nationality = '';
//   final formKey = GlobalKey<FormState>();
//   void setError(String message) {
//     error = message;
//     notifyListeners();
//   }

//   void setBio(String value) {
//     bioNotes = value;
//     notifyListeners();
//   }

//   void setPhoto(File? photo) {
//     _photo = photo;
//     notifyListeners();
//   }

//   Future<void> getPhoto(BuildContext context) async {
//     final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (photo == null) {
//       return;
//     } else {
//       final photoTemp = File(photo.path);
//       _photo = photoTemp;
//       notifyListeners();
//     }
//   }

//   Future<dynamic> updateUserProfile() async {
//     try {
//       loading = true;
//       notifyListeners();

//       if (photo != null) {
//         photoUrl = await DatabaseService(uid: currentuserId)
//             .updateImageToStorage(currentuserId, photo!);
//       }
//     } catch (error) {
//       loading = false;
//       notifyListeners();
//       return null;
//     }
//   }
// }
