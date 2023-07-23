import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:gro_better/model/experts.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/appointment/widgets/success_booking.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointment extends StatefulWidget {
  final ExpertInfo expert;
  // List<String> timeSlots = [];
  const BookAppointment({required this.expert, super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final CalendarFormat _format = CalendarFormat.month;
  final DateTime _focusDay = DateTime.now();
  final DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  final bool _dateSelected = false;
  bool _timeSelected = false;
  String selectedTime = '';
  Future<List<String>>? _updateAvailableSlotsFuture;
// List of disabled time slots
  List<String> _disabledTimeSlots = [];
//function to fetch existing bookings for the selected doctor and date
  Future<List<String>> fetchBookedSlots(DateTime selectedDate) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Experts')
        .doc(widget.expert.id)
        .collection('bookings')
        .where('date', isEqualTo: selectedDate)
        .get();

    final bookedSlots =
        snapshot.docs.map((doc) => doc['time'].toString()).toList();
    return bookedSlots;
  }

  void _updateAvailableTimeSlots(
      DateTime selectedDate, TimeOfDay fromTime, TimeOfDay toTime) async {
    // Fetch the booked slots for the selected date and doctor from Firestore
    final bookedSlots = await fetchBookedSlots(selectedDate);
    // Generate time slots for the selected doctor's working hours
    final formattedTimeSlots = generateTimeSlots(fromTime, toTime);
    // Disable time slots that are already booked
    _disabledTimeSlots = formattedTimeSlots
        .where((timeSlot) => bookedSlots.contains(timeSlot))
        .toList();

    // // Check if the current time slot is already booked, and update the _currentIndex accordingly
    if (_timeSelected &&
        bookedSlots.contains(formattedTimeSlots[_currentIndex!])) {
      _timeSelected = false;
      _currentIndex = null;
    }
  }

  @override
  void initState() {
    _isWeekend = (DateTime.now().weekday == DateTime.saturday ||
        DateTime.now().weekday == DateTime.sunday);
    //_dateSelected = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay fromTimeOfDay = TimeOfDay.fromDateTime(widget.expert.fromTime);
    TimeOfDay toTimeOfDay = TimeOfDay.fromDateTime(widget.expert.toTime);
    UserDetails? currentUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: const Text('Book Appoinment'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    kHeight10,
                    ListTile(
                      leading: CircleAvatar(
                        radius: 28.5,
                        backgroundImage: NetworkImage(widget.expert.imageUrl),
                      ),
                      title: Text(
                        widget.expert.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        'Fee:     ${widget.expert.fee}',
                        style: const TextStyle(
                            color: kButtonColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    kHeight10,
                    DividerTeal,
                    _tableCalendar(),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Center(
                        child: Text(
                          'Select Consultation Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
               _isWeekend?
              SliverToBoxAdapter(
                child:
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        alignment: Alignment.center,
                        child: const Text(
                          'Weekend is not available, please select another date',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
              )
                    : FutureBuilder<List<String>>(
                        future: _updateAvailableSlotsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While the future is loading, show a loading indicator or placeholder
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            // If there was an error while fetching the data, display an error message
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            // If the future completed successfully, build the grid using the updated _disabledTimeSlots list
                            final timeSlots =
                                generateTimeSlots(fromTimeOfDay, toTimeOfDay);
                            return SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final timeSlot = timeSlots[index];
                                  final bool isBooked =
                                      snapshot.data!.contains(timeSlot);

                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = index;
                                        _timeSelected = true;
                                        selectedTime = timeSlot;
                                      });
                                      if (isBooked) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text('Slot already booked'),
                                        ));
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _currentIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        color: (_currentIndex == index &&
                                                !isBooked)
                                            ? kPrimaryColor
                                            : isBooked
                                                ? Colors.red
                                                : null,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        timeSlot,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: (_currentIndex == index &&
                                                  !isBooked)
                                              ? Colors.white
                                              : null,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                childCount: timeSlots.length,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.2,
                              ),
                            );
                          }
                        },
                      ),
              ),

              // SliverGrid(
              //     delegate: SliverChildBuilderDelegate(
              //       (context, index) {
              //         final timeSlots =
              //             generateTimeSlots(fromTimeOfDay, toTimeOfDay);
              //         final timeSlot = timeSlots[index];
              //         final bool isBooked =
              //             _disabledTimeSlots.contains(timeSlot);

              //         return InkWell(
              //           splashColor: Colors.transparent,
              //           onTap: () {
              //             setState(() {
              //               _currentIndex = index;
              //               _timeSelected = true;
              //               selectedTime = timeSlot;
              //             });
              //             if (isBooked) {
              //               ScaffoldMessenger.of(context)
              //                   .showSnackBar(const SnackBar(
              //                 content: Text('Slot already booked'),
              //               ));
              //             }
              //           },
              //           child: Container(
              //             margin: const EdgeInsets.all(10),
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 color: _currentIndex == index
              //                     ? Colors.white
              //                     : Colors.black,
              //               ),
              //               borderRadius: BorderRadius.circular(15),
              //               color: (_currentIndex == index &&
              //                       isBooked == false)
              //                   ? kPrimaryColor
              //                   : isBooked
              //                       ? Colors.red
              //                       : null, // set red color for booked slots
              //             ),
              //             alignment: Alignment.center,
              //             child: Text(
              //               timeSlot,
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //                 color: (_currentIndex == index &&
              //                         isBooked == false)
              //                     ? Colors.white
              //                     : null,
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //       childCount:
              //           generateTimeSlots(fromTimeOfDay, toTimeOfDay)
              //               .length,
              //     ),
              //     gridDelegate:
              //         const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 4, childAspectRatio: 1.2),
              //   ),
              SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor),
                        child: const Text(' Book Now'),
                        onPressed: () async {
                          if (_timeSelected && _dateSelected) {
                            final getDate = _currentDay;
                            // final getDay = _currentDay.weekday;
                            // final getTime = selectedTime;
                            final weekDay = DateFormat('EEEE')
                                .format(DateTime(2023, 1, _currentDay.weekday));
                            try {
                              print('Inside try $selectedTime');
                              // Store booking data in the expert's collection in Firestore
                              await FirebaseFirestore.instance
                                  .collection('Experts')
                                  .doc(widget.expert
                                      .id) // Assuming 'widget.expert.id' is the ID of the selected doctor
                                  .collection(
                                      'bookings') // Create a subcollection 'bookings' inside the doctor's document
                                  .add({
                                'date': getDate,
                                'day': weekDay,
                                'time': selectedTime,
                                'user_id': currentUser!.uid,
                                'user_name': currentUser.name,
                                'timestamp':
                                    DateTime.now().millisecondsSinceEpoch,
                              });

                              // await FirebaseFirestore.instance
                              //     .collection('users')
                              //     .doc(currentUser.uid)
                              //     .collection('myBookings')
                              //     .add({
                              //   'date': getDate,
                              //   'day': weekDay,
                              //   'time': timeSlots[getTime],
                              //   'doctor_id': widget.expert.id,
                              //   'doctor_name': widget.expert.name,
                              // });

                              // Redirect to success booking page
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const SuccessBooking();
                              }));
                              // MyApp.navigatorKey.currentState!.pushNamed('success_booking');
                            } catch (e) {
                              print('Error adding booking: $e');
                            }
                          }
                        })),
              ),
        ],
        )
    )
          )
  }
        
  }

  List<String> generateTimeSlots(TimeOfDay fromTime, TimeOfDay toTime) {
    final List<String> timeSlots = [];
    final int totalSlots = calculateTotalSlots(fromTime, toTime);

    TimeOfDay currentTime = fromTime;

    for (int i = 0; i < totalSlots; i++) {
      final String formattedTime = DateFormat('hh:mm a').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        currentTime.hour,
        currentTime.minute,
      ));
      timeSlots.add(formattedTime);

      // Increment current time by 1 hour
      currentTime = TimeOfDay.fromDateTime(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        currentTime.hour,
        currentTime.minute,
      ).add(const Duration(hours: 1)));
    }

    return timeSlots;
  }

  int calculateTotalSlots(TimeOfDay fromTime, TimeOfDay toTime) {
    final DateTime fromDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      fromTime.hour,
      fromTime.minute,
    );

    final DateTime toDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      toTime.hour,
      toTime.minute,
    );

    final Duration duration = toDateTime.difference(fromDateTime);
    final int totalSlots = duration.inHours;

    return totalSlots;
  }

  Widget _tableCalendar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TableCalendar(
        focusedDay: _focusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2023, 12, 31),
        calendarFormat: _format,
        currentDay: _currentDay,
        rowHeight: 30,
        calendarStyle: const CalendarStyle(
          todayDecoration:
              BoxDecoration(color: kButtonColor, shape: BoxShape.circle),
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        onFormatChanged: (format) {
          setState(() {
            _format = format;
          });
        },
        onDaySelected: ((selectedDay, focusedDay) {
          setState(() {
            _currentDay = selectedDay;
            _focusDay = focusedDay;
            _dateSelected = true;

            //check if weekend is selected
            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
              // _currentIndex = null;
            } else {
              _isWeekend = false;
              _updateAvailableSlotsFuture = fetchBookedSlots(selectedDay);
            }
            // Update the available time slots based on the selected date
            // _updateAvailableTimeSlots(
            //     selectedDay,
            //     TimeOfDay.fromDateTime(widget.expert.fromTime),
            //     TimeOfDay.fromDateTime(widget.expert.toTime));
          });
        }),

        // Add the calendar builders to mark booked slots
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, events) {
            // Show selected date with a different background color
            return Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          // disabledBuilder: (context, day, focusedDay) {
          //   // Disable day cells for weekends
          //   if (day.weekday == 6 || day.weekday == 7) {
          //     return Center(
          //       child: Text(
          //         '${day.day}',
          //         style: const TextStyle(color: Colors.grey),
          //       ),
          //     );
          //   }

          //   // Disable day cells for dates with no available time slots
          //   if (_disabledTimeSlots.isNotEmpty &&
          //       _disabledTimeSlots
          //           .contains(DateFormat('yyyy-MM-dd').format(day))) {
          //     return Center(
          //       child: Text(
          //         '${day.day}',
          //         style: const TextStyle(color: Colors.grey),
          //       ),
          //     );
          //   }

          //   // Enable day cells for other dates
          //   return null;
          // },
        ),
      ),
    );
  }
}
