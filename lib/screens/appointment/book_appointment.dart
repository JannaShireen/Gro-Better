import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gro_better/model/experts.dart';
import 'package:gro_better/model/user_info.dart';
import 'package:gro_better/provider/user_provider.dart';
import 'package:gro_better/screens/appointment/widgets/success_booking.dart';
import 'package:gro_better/shared/constants.dart';
import 'package:gro_better/shared/razorpay_key.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookAppointment extends StatefulWidget {
  final ExpertInfo expert;
  const BookAppointment({required this.expert, Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final Razorpay _razorpay = Razorpay();
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String selectedTime = '';
  Future<List<String>>? _updateAvailableSlotsFuture;
  List<String> _disabledTimeSlots = [];

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
    final bookedSlots = await fetchBookedSlots(selectedDate);
    final formattedTimeSlots = generateTimeSlots(fromTime, toTime);
    _disabledTimeSlots = formattedTimeSlots
        .where((timeSlot) => bookedSlots.contains(timeSlot))
        .toList();

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
    _dateSelected = false;
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Perform booking procedures here after successful payment
    _bookAppointment(response.paymentId!);
    _addExperts();
    _addClients();

    // Navigate to the success booking page

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SuccessBooking(
        paymentId: response.paymentId!,
        date: DateFormat('MMMM d').format(_currentDay),
        time: selectedTime,
        category: widget.expert.category,
        image: widget.expert.imageUrl,
        name: widget.expert.name,
      ),
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure, if needed
    print("Payment error: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response, if needed
    print("External wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay fromTimeOfDay = TimeOfDay.fromDateTime(widget.expert.fromTime);
    TimeOfDay toTimeOfDay = TimeOfDay.fromDateTime(widget.expert.toTime);
    UserDetails? currentUser = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Book Appointment',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  color: kButtonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            kHeight10,
            DividerTeal,
            _tableCalendar(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: Text(
                  'Select Consultation Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            if (_isWeekend)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
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
            else
              Expanded(
                child: FutureBuilder<List<String>>(
                  future: _updateAvailableSlotsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      final timeSlots =
                          generateTimeSlots(fromTimeOfDay, toTimeOfDay);
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: timeSlots.length,
                        itemBuilder: (context, index) {
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Slot already booked. Please choose another slot'),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (_currentIndex == index && !isBooked)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: (_currentIndex == index && !isBooked)
                                    ? Colors.green
                                    : isBooked
                                        ? Colors.grey
                                        : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                timeSlot,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (_currentIndex == index && !isBooked)
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Please choose a date'),
                      );
                    }
                  },
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                child: const Text('Book Now'),
                onPressed: () async {
                  if (_timeSelected && _dateSelected) {
                    final multipliedFee = widget.expert.fee! * 100;
                    final options = {
                      'key': myRazorPayKey,
                      'amount':
                          multipliedFee, // amount in paise (e.g., for Rs. 100, it should be 10000)
                      'name': 'Gro Better',
                      'description': 'Appointment Booking',
                      'prefill': {
                        // User's phone number
                        'email': currentUser!.email, // User's email address
                      },
                    };

                    try {
                      _razorpay.open(options);
                    } catch (e) {
                      print('Error initiating payment: $e');
                      Fluttertoast.showToast(
                          msg: 'Error occured during payment',
                          timeInSecForIosWeb: 4);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
          todayDecoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
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

            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
            } else {
              _isWeekend = false;
              _updateAvailableSlotsFuture = fetchBookedSlots(selectedDay);
            }
          });
        }),
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, events) {
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
        ),
      ),
    );
  }

  void _bookAppointment(String responseId) async {
    UserDetails? currentUser =
        Provider.of<UserProvider>(context, listen: false).getUser;

    if (_timeSelected && _dateSelected) {
      final getDate = _currentDay;
      final weekDay =
          DateFormat('EEEE').format(DateTime(2023, 1, _currentDay.weekday));

      try {
        await FirebaseFirestore.instance
            .collection('Experts')
            .doc(widget.expert.id)
            .collection('bookings')
            .add({
          'payment_id': responseId,
          'date': getDate,
          'day': weekDay,
          'time': selectedTime,
          'user_id': currentUser!.uid,
          'user_name': currentUser.name,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentuserId)
            .collection('myBookings')
            .add({
          'payment_id': responseId,
          'date': getDate,
          'day': weekDay,
          'time': selectedTime,
          'expert_id': widget.expert.id,
          'expert_name': widget.expert.name,
          'expert_dp': widget.expert.imageUrl,
          'category': widget.expert.category,
        });
      } catch (e) {
        print('Error adding booking: $e');
      }
    }
  }

  // function to add a new client to myClient list in the Expert Collection
  Future _addClients() async {
    UserDetails? currentUser =
        Provider.of<UserProvider>(context, listen: false).getUser;
    String clientName = currentUser!.name;

    try {
      // Get the reference to the 'myClients' collection
      CollectionReference myClientsCollection = FirebaseFirestore.instance
          .collection('Experts')
          .doc(widget.expert.id)
          .collection('myClients');

      // Query to check if the client name already exists in the collection
      QuerySnapshot querySnapshot = await myClientsCollection
          .where('id', isEqualTo: currentUser.uid)
          .get();

      // If the client name does not exist in the collection, add it
      if (querySnapshot.docs.isEmpty) {
        await myClientsCollection.add({
          'id': currentUser.uid,
          'name': clientName,
          'email': currentUser.email,
        });
        debugPrint('Client added successfully.');
      } else {
        debugPrint('Client already exists in the collection.');
      }
    } catch (e) {
      print('Error adding client: $e');
    }
  }

//Function to add new doctor to myDoctors collection in the user Collection
  Future _addExperts() async {
    UserDetails? currentUser =
        Provider.of<UserProvider>(context, listen: false).getUser;
    String clientName = currentUser!.name;

    try {
      // Get the reference to the 'myClients' collection
      CollectionReference myExpertsCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('myExperts');

      // Query to check if the client name already exists in the collection
      QuerySnapshot querySnapshot = await myExpertsCollection
          .where('name', isEqualTo: widget.expert.id)
          .get();

      // If the client name does not exist in the collection, add it
      if (querySnapshot.docs.isEmpty) {
        await myExpertsCollection.add({
          'id': widget.expert.id,
          'name': widget.expert.name,
          'email': widget.expert.email,
        });
        debugPrint('Client added successfully.');
      } else {
        debugPrint('Client already exists in the collection.');
      }
    } catch (e) {
      print('Error adding client: $e');
    }
  }
}
