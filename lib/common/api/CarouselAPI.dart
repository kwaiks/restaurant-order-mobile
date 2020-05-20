
import 'dart:convert';

import 'package:mesan_mobile/common/const/Types.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Carousel>> fetchCarouselList() async {
  try {
    String data = await rootBundle.loadString('assets/data/slider.json');
    List carousel = json.decode(data);
    return carousel.map((cars)=> new Carousel.fromJson(cars)).toList();
  } catch (e) {
    print(e);
  }
  return null;
}