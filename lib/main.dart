import 'package:flutter/material.dart';
import 'package:world_clock/pages/home.dart';
import 'package:world_clock/pages/loading.dart';
import 'package:world_clock/pages/search.dart';
import 'package:world_clock/pages/selection.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => const Loading(),
      "/home": (context) => const Home(),
      "/location": (context) => const LocationSelector(),
      "/search": (context) => const SearchPage()
    },
  ));
}
