import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldClock {
  String? location;
  String? time;
  String? date;
  String? flag;
  String? url;
  String? offset;
  bool? isDaytime = false;

  WorldClock(
      {this.location,
      this.time,
      this.date,
      this.flag,
      this.url,
      this.offset,
      this.isDaytime});

  Future<void> getTime() async {
    try {
      Response res =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(res.body);

      String datetime = data['datetime'].substring(0, 25);

      DateTime current = DateTime.parse(datetime);

      if (current.hour > 6 && current.hour < 18) {
        isDaytime = true;
      } else {
        isDaytime = false;
      }

      time = DateFormat.Hm().format(current);
      date = DateFormat.yMMMMd('en_US').format(current);
      offset = data['utc_offset'];

      var index = url?.indexOf("/");
      location = url?.substring(index! + 1);
    } catch (e) {
      time = 'Could Not Find the Available Clock';
    }
  }

  Future<void> getCurrentTime() async {
    try {
      Response res = await get(Uri.parse('http://worldtimeapi.org/api/ip'));
      Map data = jsonDecode(res.body);
      url = data['timezone'];
      await getTime();
    } catch (e) {
      time = 'Could Not Find the Available Clock';
    }
  }

  Future<List> getTimezones() async {
    Response res = await get(Uri.parse('http://worldtimeapi.org/api/timezone'));
    List data = jsonDecode(res.body);
    return data;
  }
}
