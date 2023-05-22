import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rumble_futsal/components/custom_appbar.dart';

import '../components/ground_card.dart';
import '../models/auth_model.dart';

class AllGrounds extends StatefulWidget {
  const AllGrounds({super.key});

  @override
  State<AllGrounds> createState() => _AllGroundsState();
}

class _AllGroundsState extends State<AllGrounds> {
  Map<String, dynamic> user = {};
 
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthModel>(context, listen: false).getUser;
  
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: "Please Select A Ground",
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
             
        
              Column(
                children: List.generate(
                  user['ground'].length,
                  (index) {
                    return GroundCard(
                      // route: 'ground_details',
                      ground: user['ground'][index],
                    
                      isFav: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
