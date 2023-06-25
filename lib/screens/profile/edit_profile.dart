import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
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
    String selectedCountry = '';
    UserDetails userInfo = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kHeight30,
                // Profile picture picker
                // Center(
                //   child: SizedBox(
                //     height: 150,
                //     width: 150,
                //     child: Image.asset(
                //       'assets/images/empty-user.png',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.black,
                //   ),
                //   onPressed: () {
                //     EditProfileProvider().getPhoto(context);
                //   },
                //   icon: const Icon(Icons.image_outlined),
                //   label: const Text('Add An Image'),
                // ),
                kHeight20,
                bioText,

                TextFormFieldWidget(
                  //  initialValue: userInfo.bioNotes ?? "",
                  hintText: "Enter a bionote...",
                  maxLength: 20,
                  controller: bioNotes,
                ),
                // Bio text field

                kHeight10,
                // Country dropdown field
                nationalityText,

                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kButtonColor),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (onSelect) {
                        setState(() {
                          selectedCountry = onSelect.name.toString();
                          selectCountryText = selectedCountry;
                        });
                      },
                      countryListTheme: const CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight:
                            450, // Optional. Country list modal height
                        //Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                    );
                  },
                  child: Text(selectCountryText),
                ),
                kHeight20,
                DividerTeal,

                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: kButtonColor),
                    onPressed: () async {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        await DatabaseService(uid: currentuserId)
                            .editUserData(bioNotes.text, selectedCountry);
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
