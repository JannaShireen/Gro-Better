import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gro_better/screens/experts/widgets/doctor_profile.dart';
import 'package:gro_better/shared/constants.dart';

import 'widgets/doctor_short_bio.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  final TextEditingController _textController = TextEditingController();
  String search = '';
  var _length = 0;

  @override
  void initState() {
    super.initState();
    search = _textController.text;
    _length = search.length;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text('Find Experts'),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: gradientColor),
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Search for Experts',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                prefixStyle: TextStyle(
                  color: Colors.grey[300],
                ),
                suffixIcon: _textController.text.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            _textController.clear();
                            _length = search.length;
                          });
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                        ),
                      )
                    : const SizedBox(),
              ),
              // onFieldSubmitted: (String _searchKey) {
              //   setState(
              //     () {
              //       print('>>>' + _searchKey);
              //       search = _searchKey;
              //     },
              //   );
              // },
              onChanged: (String searchKey) {
                setState(
                  () {
                    print('>>>$searchKey');
                    search = searchKey;
                    _length = search.length;
                  },
                );
              },
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textInputAction: TextInputAction.search,
              autofocus: false,
            ),
            kHeight10,
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorProfile()),
                      );
                    },
                    child: const Card(
                      color: kBackgroundColor,
                      elevation: 5,
                      child: DoctorShortBio(),
                      // child: SizedBox(
                      //   height: 90,
                      //   child: ListTile(
                      //     leading: const ProfilePic(imageUrl: 'alan.jpg'),
                      //     title: const Text('Alan Walker'),
                      //     subtitle: const Text(
                      //         'Clinical Psychologist'), // Uncomment this line
                      //     trailing: ElevatedButton(
                      //       onPressed: () {},
                      //       child: const Text('Book Now'),
                      //     ),
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            )

            // Expanded(
            //   child: GridView.count(
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //     crossAxisCount: 2,
            //     children: [
            //       Card(
            //         color: kBackgroundColor,
            //         elevation: 5,
            //         child: SizedBox(
            //           height: 90,
            //           child: ListTile(
            //             leading: const ProfilePic(imageUrl: 'alan.jpg'),
            //             title: const Text('Alan Walker'),
            //             // subtitle: const Text('Clinical Psychologist'),
            //             trailing: ElevatedButton(
            //                 onPressed: () {}, child: const Text('Book Now')),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );

    // actions: <Widget>[
    //     SafeArea(
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
    //         width: MediaQuery.of(context).size.width,
    //         child: TextFormField(
    //           controller: _textController,
    //           decoration: InputDecoration(
    //             contentPadding:
    //                 const EdgeInsets.only(left: 20, top: 10, bottom: 10),
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10),
    //               borderSide: BorderSide.none,
    //             ),
    //             filled: true,
    //             fillColor: Colors.grey[300],
    //             hintText: 'Search for Experts',
    //             hintStyle: GoogleFonts.lato(
    //               color: Colors.black26,
    //               fontSize: 18,
    //               fontWeight: FontWeight.w800,
    //             ),
    //             prefixIcon: const Icon(
    //               FlutterIcons.search1_ant,
    //               size: 20,
    //             ),
    //             prefixStyle: TextStyle(
    //               color: Colors.grey[300],
    //             ),
    //             suffixIcon: _textController.text.isNotEmpty
    //                 ? TextButton(
    //                     onPressed: () {
    //                       setState(() {
    //                         _textController.clear();
    //                         _length = search.length;
    //                       });
    //                     },
    //                     child: const Icon(
    //                       Icons.close_rounded,
    //                       size: 20,
    //                     ),
    //                   )
    //                 : const SizedBox(),
    //           ),
    //           // onFieldSubmitted: (String _searchKey) {
    //           //   setState(
    //           //     () {
    //           //       print('>>>' + _searchKey);
    //           //       search = _searchKey;
    //           //     },
    //           //   );
    //           // },
    //           onChanged: (String searchKey) {
    //             setState(
    //               () {
    //                 print('>>>$searchKey');
    //                 search = searchKey;
    //                 _length = search.length;
    //               },
    //             );
    //           },
    //           style: GoogleFonts.lato(
    //             fontSize: 18,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           textInputAction: TextInputAction.search,
    //           autofocus: false,
    //         ),
    //       ),
    //     )
    //   ],
    // ),

    //SearchList(
    //searchKey: search,
    // ),
  }
}


  
// class ExpertScreen extends StatelessWidget {
//   const ExpertScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Experts',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color.fromARGB(248, 64, 123, 96),
//         centerTitle: true,
//       ),
//       body: ExpertListWidget(),
//     );
//   }
// }
