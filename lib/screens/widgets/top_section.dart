import 'package:flutter/material.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/profile/edit_profile.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:provider/provider.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/add-user-dp.png'),
          ),
          Column(
            children: [
              Text(
                ' ${userInfo?.name}',
                //'${document['name']}',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              kHeight10,
              Text(
                'Born on ${'${userInfo?.dob}'.split(" ")[0]}',
                //  'DOB: ${'${document['DOB']}.'.split(" ")[0]}',
                style: textStyle2,
              ),
              kHeight20,

              // Text('DOB:  ${document['DOB']}', style: textStyle2),
              // const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kButtonColor)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const EditProfile())));
                },
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
