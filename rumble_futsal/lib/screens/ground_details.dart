import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rumble_futsal/components/button.dart';
import 'package:rumble_futsal/components/custom_appbar.dart';

import '../utils/config.dart';

class GroundDetails extends StatefulWidget {
  const GroundDetails({super.key});

  @override
  State<GroundDetails> createState() => _GroundDetailsState();
}

class _GroundDetailsState extends State<GroundDetails> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Ground Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          //Favourite button
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon: FaIcon(isFav
                ? Icons.favorite_rounded
                : Icons.favorite_border_outlined),
            color: Colors.red,
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          //ground avator and info
          const AboutGround(),

          //detail of ground
          const DetailBody(),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              width: double.infinity,
              title: 'Book Ground',
              onPressed: () {
                //Navigate to booking page
                Navigator.of(context).pushNamed('booking_ground_page');
              },
              disable: false,
            ),
          ),
        ],
      )),
    );
  }
}

class AboutGround extends StatelessWidget {
  const AboutGround({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage('assets/ground2.JPG'),
            backgroundColor: Colors.white,
          ),
          Config.spaceSmall,
          const Text(
            'Ground 2',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              '5A side futsal ground',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Rumble Futsal',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          const GroundInfo(),
          Config.spaceMedium,
          const Text(
            'About Ground',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          Config.spaceSmall,
          const Text(
            'This Ground can accomodate 5 players from each team. It has good turf. Playes can get premium experience playing here',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class GroundInfo extends StatelessWidget {
  const GroundInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        InfoCard(value: '109', label: 'Games Played'),
        SizedBox(
          width: 15.0,
        ),
        InfoCard(value: '2 years', label: 'Ground Age'),
        SizedBox(
          width: 15.0,
        ),
        InfoCard(value: '4.8', label: 'Rating'),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 15.0,
        ),
        child: Column(children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ]),
      ),
    );
  }
}
