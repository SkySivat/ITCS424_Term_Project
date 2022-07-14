import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_clock/services/worldclock.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<WorldClock> timezones = [];
  List<WorldClock> displayList = [];

  void getTimezone() async {
    Response res = await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
    List data = jsonDecode(res.body);
    for (var i in data) {
      WorldClock ins = WorldClock(url: i);
      setState(() {
        timezones.add(ins);
      });
    }
    displayList = List.from(timezones);
  }

  void updateList(String value) {
    setState(() {
      displayList = timezones
          .where((element) =>
              element.url!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateTime(index) async {
    WorldClock newTime = WorldClock(url: displayList[index].url);
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
  void initState() {
    super.initState();
    getTimezone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search Locations",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.indigo[400],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                hintText: "Enter City Name...",
                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => updateList(value),
            ),
            const SizedBox(height: 20.0),
            Expanded(
                child: ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            updateTime(index);
                          },
                          title: Text(
                            "${displayList[index].url}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          contentPadding: const EdgeInsets.all(8.0),
                        ))),
          ],
        ),
      ),
    );
  }
}
