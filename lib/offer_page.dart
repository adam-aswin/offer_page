import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:lottie/lottie.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  List<Map<String, dynamic>> hotels = [
    {
      'name': 'Forte Kochi',
      'image': './images/hotel-1.jpg',
      'address': '1/373. Princes Street Fort Kochi, 682001 Cochin, India',
      'price': 2000,
      'status': 'InActive'
    },
    {
      'name': 'Ginger Kochi',
      'image': './images/hotel-2.jpg',
      'address':
          ' Metro Pillar 668, Doraiswamy Iyer Rd, off Mahatma Gandhi Road, Shenoys, Kochi, Ernakulam, Kerala 682035',
      'price': 1500,
      'status': 'InActive'
    },
    {
      'name': 'THE SENATE HOTEL',
      'image': './images/hotel-3.jpg',
      'address': 'Providence Rd, Kacheripady, Ernakulam, Kerala',
      'price': 1800,
      'status': 'InActive'
    },
    {
      'name': 'Le Maritime Kochi',
      'image': './images/hotel-4.webp',
      'address':
          'XIV/144 A - 144 J, LE MARITIME KOCHI, GOSREE JUNCTION, PUTHUVYPE, Vypin, Kochi, Kerala',
      'price': 1300,
      'status': 'InActive'
    },
    {
      'name': 'Hotel Cochin Legacy',
      'image': './images/hotel-5.jpg',
      'address':
          'NH 66, Bye Pass Highway, near Royal Drive Showroom and Nairs Hospital, Kundannoor, Vyttila, Kochi, Kerala',
      'price': 1600,
      'status': 'InActive'
    },
  ];
  late Timer _timer;
  bool isDealChange = false;
  int offPrice = 0;
  int minutes = 14;
  int seconds = 59;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerPrice();
    offerPeriod();
  }

  void offerAlert() async {
    await FlutterPlatformAlert.playAlertSound();
  }

  void offerPrice() {
    List<int> price = [];
    for (Map i in hotels) {
      print("======================================");
      price.add(i['price']);
      price.sort();
      offPrice = price.first;
      print(price);
    }
  }

  void offerPeriod() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (minutes == 00 && seconds == 00) {
            minutes = 14;
            seconds = 59;
            hotels.removeWhere(
              (element) => element['price'] == offPrice,
            );

            isDealChange = true;
            Future.delayed(
              Duration(seconds: 4),
              () => isDealChange = false,
            );
            offerPrice();
            offerAlert();
          } else if (seconds == 00) {
            minutes--;
            seconds = 59;
          } else {
            seconds--;
          }
        });
      },
    );
    offerPrice();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Deal In Progress",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red[600],
            ),
            onPressed: () {},
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15),
              height: 100,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: BorderDirectional(
                    end: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                    start: BorderSide(
                      color: Colors.green,
                      width: 2,
                    )),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Best Offer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "₹ $offPrice",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Protest",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Offer Ends In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Text(
                                "MIN: ${minutes.toString().padLeft(2, '0')}  SEC:${seconds.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontFamily: "Protest",
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: isDealChange
                        ? Lottie.asset(
                            "./lib/Lottie/Animation - 1734546620258.json",
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width,
                          )
                        : null,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                var data = hotels[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 5,
                    //     spreadRadius: 0,
                    //     offset: Offset(5, 5),
                    //     color: Colors.black38,
                    //   ),
                    // ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 81,
                        height: 81,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            data['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            data['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 140,
                                child: Text(
                                  maxLines: 1,
                                  data['address'],
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Text(
                                "₹ ${data['price']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: data['status'] == 'InActive'
                                        ? Colors.amber
                                        : Colors.green,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data['status'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 72, 169, 77),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.only(left: 20, right: 20)),
                        onPressed: () {},
                        child: Text("Book Now"),
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
