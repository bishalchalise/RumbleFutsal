import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rumble_futsal/components/custom_appbar.dart';
import 'package:rumble_futsal/utils/config.dart';

class RefereeProfile extends StatelessWidget {
  const RefereeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Referees',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
              Column(
                children: const [
                  RefereeCard(
                    image: 'assets/referee2.jpeg',
                    name: 'Nakesh Raut',
                    phone: '9869647138',
                    
                  ),
                   RefereeCard(
                    image: 'assets/referee2.jpeg',
                    name: 'Arnold Alexander',
                    phone: '9834456376',
                  ),
                   RefereeCard(
                    image: 'assets/referee2.jpeg',
                    name: 'Manish Shah',
                    phone: '9823453432',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RefereeCard extends StatelessWidget {
  const RefereeCard({
    super.key,
    required this.image,
    required this.name,
   
    required this.phone,
 
  });
  final String image;
  final String name;
  
  final String phone;
  

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      height: 150,
      child: Card(
        elevation: 5,
        color: Config.primaryColor,
        child: Row(
          children: [
            SizedBox(
              width: Config.widthSize * 0.33,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                   const Text(
                      'Rs 500/hour',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          phone,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,),
                              
                        ),
                        const Spacer(
                          flex: 7,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
