import 'package:flutter/material.dart';
import 'package:gro_better/shared/constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('About us'),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "At Gro Better, we recognize the importance of maintaining your mental health. We are a top supplier of easy, approachable, and compassionate online psychotherapy sessions created to meet the particular requirements of people in Qatar. Our group of qualified and experienced therapists is committed to assisting you in navigating the difficulties of life while offering a secure and encouraging atmosphere for your emotional well-being. We are available to offer assistance whether you need it for depression, relationship problems, anxiety, or any other mental health condition.You can communicate with your therapist using our user-friendly and secure online platform without leaving the comfort of your home, protecting your privacy and avoiding the need for travel. We place a high importance on cultural awareness and respect, making sure that our offerings are customized for the varied clientele we serve in Qatar.Gro Better provides flexible scheduling options and reasonable fees because we think everyone should have access to high-quality mental health care. We value your journey with mental health and work to give you the resources and assistance you require to live a happy and balanced life.Today, start down the path to a happier, healthier you. Let us accompany you on your life-changing path toward emotional wellbeing. Together, we can Gro for a better and brighter future."),
            ],
          ),
        ),
      ),
    );
  }
}
