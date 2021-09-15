import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = ""; // location name for UI
  String time = ""; // the time in location
  String flag = ""; // url to an asset flag icon
  String url = ""; // location url for api endpoint
  bool isDaytime = true; // day time or not

  WorldTime({this.location = '', this.flag = '', this.url = ''});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      // get properties from data
      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(2, 3);
      String offset2 = data['utc_offset'].substring(4, 6);

      //print(datetime);
      //print(offset1);

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      //set time property

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('samir we caught error $e');
      time = 'could not get data';
    }
  }
}
