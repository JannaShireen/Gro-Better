import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/widgets/profile_pic.dart';

class DoctorShortBio extends StatelessWidget {
  const DoctorShortBio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        kHeight20,
        ProfilePic(
          imageUrl: 'alan.jpg',
        ),
        DrBioNotes(),
      ],
    );
  }
}

class DrBioNotes extends StatelessWidget {
  const DrBioNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight10,
        const Text(
          'Ryan Reynolds',
          style: headingTextStyle,
        ),
        kHeight10,
        Text(
          'Clinical Psychologist',
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        kHeight10,
        Text(
          'Rating:  ⭐ ⭐ ⭐ ⭐ ⭐ ',
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}
