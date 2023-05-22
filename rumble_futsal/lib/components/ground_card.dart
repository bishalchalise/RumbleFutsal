import 'package:flutter/material.dart';
import 'package:rumble_futsal/main.dart';
import 'package:rumble_futsal/screens/ground_details.dart';

import '../utils/config.dart';

class GroundCard extends StatelessWidget {
  const GroundCard({
    super.key,
    required this.ground,
    required this.isFav,
   
  });

  final Map<String, dynamic> ground; //to recieve ground details

  final bool isFav;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: Image.network(
                  "http://127.0.0.1:8000${ground['ground_profile']}",
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
                        '${ground['ground_name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${ground['category']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:   <Widget>[
                          const Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                            size: 16,
                          ),
                        //  Spacer(
                        //     flex: 1,
                        //   ),
                         Text(
                          '${ground['price']}',
                         style: const TextStyle(
                          fontSize: 20.0, 
                          color: Colors.green,
                          fontWeight: FontWeight.w500
                         ),
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
        onTap: () {
          MyApp.navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => GroundDetails(
                ground: ground,
                isFav: isFav,
              ),
            ),
          );

          // Navigator.of(context).pushNamed(route, arguments: ground);
        }, //redirect to ground details
      ),
    );
  }
}
