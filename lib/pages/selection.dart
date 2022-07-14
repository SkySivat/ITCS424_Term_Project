import 'package:flutter/material.dart';
import 'package:world_clock/services/worldclock.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({Key? key}) : super(key: key);

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  List<WorldClock> locations = [
    WorldClock(url: 'Asia/Bangkok', location: 'Bangkok', flag: 'th.png'),
    WorldClock(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldClock(url: 'America/New_York', location: 'New York', flag: 'us.png'),
    WorldClock(
        url: 'America/Los_Angeles', location: 'Los Angeles', flag: 'us.png'),
    WorldClock(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'jp.png'),
    WorldClock(url: 'Asia/Seoul', location: 'Seoul', flag: 'kr.png'),
    WorldClock(url: 'Asia/Singapore', location: 'Singapore', flag: 'sg.png'),
    WorldClock(url: 'Asia/Dubai', location: 'Dubai', flag: 'ae.png'),
    WorldClock(url: 'Europe/Moscow', location: 'Moscow', flag: 'ru.png'),
  ];

  void updateTime(index) async {
    WorldClock newTime = locations[index];
    await newTime.getTime();

    Navigator.pop(context, {
      'location': newTime.location,
      'time': newTime.time,
      'date': newTime.date,
      'flag': newTime.flag,
      'url': newTime.url,
      'isDaytime': newTime.isDaytime,
      'gmtOffset': newTime.offset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text("Choose a Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (contex, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  textColor: Colors.white,
                  tileColor: Colors.indigo[900],
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location.toString()),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/${locations[index].flag}"),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
