import 'package:flutter/material.dart';
import 'package:world_clock/services/worldclock.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldClock myLocation = WorldClock();
    await myLocation.getCurrentTime();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': myLocation.location,
      'flag': myLocation.flag,
      'time': myLocation.time,
      'date': myLocation.date,
      'isDaytime': myLocation.isDaytime,
      'gmtOffset': myLocation.offset
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "World Clock",
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50.0),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 150.0,
              )
            ],
          ),
        ));
  }
}
