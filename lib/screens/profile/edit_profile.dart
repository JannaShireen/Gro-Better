import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/authenticate/widgets/text_form_field.dart';
import 'package:gro_better/services/database/database.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController bioNotes = TextEditingController();
  String selectCountryText = 'Select Country';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // String selectedCountry = '';
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: kBackgroundColor2,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Edit Bio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight30,

                kHeight10,
                TextFormFieldWidget(
                  //  initialValue: userInfo.bioNotes ?? "",
                  hintText: "Enter a bionote...",
                  maxLength: 20,
                  controller: bioNotes,
                  maxLines: 4,
                ),
                // Bio text field

                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: kButtonColor),
                    onPressed: () async {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        await DatabaseService(uid: currentuserId)
                            .editUserData(bioNotes.text, selectCountryText);
                        // Show Snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Edited successfully')),
                        );
                        // Navigate back to profile page
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Done')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
