import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    if ((data.isEmpty)) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
    } else {
      data = data;
    }

    // set bg
    String bgImg;
    if (data['isDaytime']) {
      bgImg = 'day.png';
    } else {
      bgImg = 'night.png';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, '/search');
              if (result != null) {
                setState(() {
                  data = result;
                });
              }
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 40,
            ),
            tooltip: "Search Locations"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/$bgImg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
          child: Column(
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  dynamic newValue =
                      await Navigator.pushNamed(context, '/location');
                  if (newValue != null) {
                    setState(() {
                      data = newValue;
                    });
                  }
                },
                icon: const Icon(
                  Icons.edit_location,
                  color: Colors.red,
                ),
                iconSize: 50,
                tooltip: 'Select location',
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Text(
                data['time'],
                style: const TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                    color: Colors.white),
              ),
              const SizedBox(height: 50.0),
              Text(
                data['date'],
                style: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                "(GMT${data['gmtOffset']})",
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.0,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
