import 'package:flutter/material.dart';
import 'package:gro_better/services/auth.dart';
import 'package:gro_better/shared/constants.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8),
              Text(
                'Gro Better',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //     Row(
              //       children: [
              //         CircleAvatar(
              //           radius: 25,
              //         ),
              //         SizedBox(
              //             width:
              //                 10), // Add some spacing between the CircleAvatar and TextFormField
              //         Expanded(
              //           child: GestureDetector(
              //             onTap: () {},
              //             child: TextFormField(
              //               decoration: InputDecoration(
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(
              //                       50.0), // Adjust the border radius as desired
              //                   borderSide: BorderSide(
              //                     color: Colors.blue, // Set the border color
              //                     width: 2.0, // Set the border width
              //                   ),
              //                 ),
              //                 hintText: 'Whats on your mind?',
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              kHeight20,
              Container(
                margin: EdgeInsets.only(left: 17),
                height: 120,
                width: 420,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the border radius as desired
                ),
                child: Center(
                    child: Text(
                  'You have no scheduled appointment.',
                  style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
              kHeight20,
              TextField(
                //controller: _statusController,
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    // Get the status text
                    // String status = _statusController.text;

                    // Perform any necessary actions with the status (e.g., post to an API)

                    // Clear the text field
                    // _statusController.clear();
                  },
                  child: Text('Post'),
                ),
              ),
              // StatusFeedWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// class StatusFeedWidget extends StatelessWidget {
//   final List<String> statusList = [
//     'Status 1',
//     'Status 2',
//     'Status 3',
//     // Add more status updates here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: statusList.length,
//       itemBuilder: (context, index) {
//         final status = statusList[index];
//         return StatusItem(status: status);
//       },
//     );
//   }
// }

// class StatusItem extends StatelessWidget {
//   final String status;

//   const StatusItem({required this.status});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Text(
//         status,
//         style: TextStyle(fontSize: 18.0),
//       ),
//     );
//   }

