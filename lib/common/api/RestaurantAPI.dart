import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Restaurant>> fetchRestaurantByNearest() async{
  try{
    String data = await rootBundle.loadString('assets/data/restaurant.json');
    List restaurants = json.decode(data);
    List<Restaurant> restoList = restaurants.map((val)=> new Restaurant.fromJson(val)).toList();
    restoList.sort((a,b)=>a.distance.compareTo(b.distance));
    return restoList;
  }catch(e){
    print(e);
    return null;
  }
}

Future<List<Restaurant>> fetchRestaurantTopPicks() async{
  try{
    String data = await rootBundle.loadString('assets/data/restaurant.json');
    List restaurants = json.decode(data);
    return restaurants.map((val)=> new Restaurant.fromJson(val)).toList();
  }catch(e){
    print(e);
    return null;
  }
}

Future<List<Restaurant>> fetchRestaurantByName(String name) async {
  try{
    String data = await rootBundle.loadString('assets/data/restaurant.json');
    List restaurants = json.decode(data);
    List<Restaurant> restoList = restaurants.map((val)=> new Restaurant.fromJson(val)).toList();
    restoList = restoList.where((val)=>val.storeName.indexOf(name) != -1 || val.category.indexOf(name) != - 1).toList();
    restoList.sort((a,b)=>a.distance.compareTo(b.distance));
    return restoList;
  }catch(e){
    print(e);
    return null;
  }
}

Future<List<Restaurant>> fetchRestaurantByCategory({String name, String category}) async {
  try{
    String data = await rootBundle.loadString('assets/data/restaurant.json');
    List restaurants = json.decode(data);
    List<Restaurant> restoList = restaurants.map((val)=> new Restaurant.fromJson(val)).toList();
    restoList = restoList.where((val)=>val.storeName.indexOf(name) != -1 && val.category.indexOf(category) != - 1).toList();
    restoList.sort((a,b)=>a.distance.compareTo(b.distance));
    return restoList;
  }catch(e){
    print(e);
    return null;
  }
}