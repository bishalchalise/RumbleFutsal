import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rumble_futsal/components/button.dart';
import 'package:rumble_futsal/components/custom_appbar.dart';
import 'package:rumble_futsal/models/auth_model.dart';
import 'package:rumble_futsal/providers/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class GroundDetails extends StatefulWidget {
  const GroundDetails({
    super.key,
    required this.ground,
    required this.isFav,
  });

  final Map<String, dynamic> ground;
  final bool isFav;

  @override
  State<GroundDetails> createState() => _GroundDetailsState();
}

class _GroundDetailsState extends State<GroundDetails> {
  Map<String, dynamic> ground = {};
  bool isFav = false;

  @override
  void initState() {
    ground = widget.ground;
    isFav = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get arguement passed from ground card
    // final ground = ModalRoute.of(context)!.settings.arguments as Map
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Ground Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          //Favourite button
          IconButton(
            //press to add/remove favourite ground
            onPressed: () async {
              //get latest favourite list form auth model
              final list =
                  Provider.of<AuthModel>(context, listen: false).getFav;

              //if ground id already exists , remove
              if (list.contains(ground['ground_id'])) {
                list.removeWhere((id) => id == ground['ground_id']);
              } else {
                //else add
                list.add(ground['ground_id']);
              }
              //update the list into auth model and notify all widgets
              Provider.of<AuthModel>(context, listen: false).setFavList(list);
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final token = prefs.getString('token') ?? '';

              if (token.isNotEmpty && token != '') {
                //update the fav list into data base
                final response =
                    await DioProvider().storeFavGround(token, list);
                if (response == 200) {
                  setState(() {
                    isFav = !isFav; //change favourite status
                  });
                }
              }
            },
            icon: FaIcon(isFav
                ? Icons.favorite_rounded
                : Icons.favorite_border_outlined),
            color: Colors.red,
          )
        ],
      ),
      body: SafeArea(
          //to pass ground details

          child: Column(
        children: <Widget>[
          //ground avator and info
          AboutGround(
            ground: ground,
          ),

          //detail of ground
          DetailBody(
            ground: ground,
         
          ),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              width: double.infinity,
              title: 'Book Ground',
              onPressed: () {
                //to pass ground id for booking process

                Navigator.of(context).pushNamed('booking_ground_page',
                    arguments: {"ground_id": ground['ground_id']});
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
  const AboutGround({super.key, required this.ground});
  final Map<dynamic, dynamic> ground;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: NetworkImage(
                "http://127.0.0.1:8000${ground['ground_profile']}"),
            backgroundColor: Colors.white,
          ),
          Config.spaceSmall,
          Text(
            '${ground['ground_name']}',
            style: const TextStyle(
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
  const DetailBody({super.key, required this.ground,});
  final Map<dynamic, dynamic> ground;
  
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          GroundInfo(
            totalBookings: ground['total_bookings'],
            price: ground['price'],
          
          ),
          Config.spaceMedium,
          const Text(
            'About Ground',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          Config.spaceSmall,
          Text(
            'This ${ground['ground_name']} is ${ground['category']}. It has good turf. Playes can get premium experience playing here \nBio Data: \n${ground['bio_data']}',
            style: const TextStyle(
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
  const GroundInfo({
    super.key,
    required this.totalBookings,
    required this.price,
 
  });
  final int totalBookings;
  final int price;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(value: '$totalBookings', label: 'Total Bookings'),
        const SizedBox(
          width: 15.0,
        ),
        InfoCard(value: '$price', label: 'Price'),
        const SizedBox(
          width: 15.0,
        ),
        const InfoCard(value: 'Yes', label: 'Availability'),
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
          vertical: 15.0,
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
