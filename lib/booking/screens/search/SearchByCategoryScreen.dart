import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/api/RestaurantAPI.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/widgets/RestaurantList.dart';

class SearchCategoryScreen extends StatefulWidget {
  final String category;
  SearchCategoryScreen({this.category});
  @override
  _SearchCategoryState createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategoryScreen> {
  TextEditingController searchController;
  Future<List<Restaurant>> restoList;
  Timer searchOnStoppedTyping;

  String search = "";
  bool _onSearch = false;

  @override
  void initState(){
    searchController = TextEditingController();
    restoList = fetchRestaurantByCategory(category: widget.category, name: search);
    super.initState();
  }

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  //Back Button Functionality
  bool popChecker() {
    if(searchController.text.isNotEmpty || _onSearch){
      searchController.clear();
      setState(() {
        _onSearch = false;
      });
      return false;
    }
    return true;
  }

  //Back Button from Button
  Future<bool> onWillPopButton() async {
    if(popChecker()){
      return Navigator.of(context).pop();
    }
    return false;
  }

  //Back button from hardware button
  Future<bool> onWillPop() async {
    return popChecker();
  }

  //Input change event
  void onChange(String input){
    const duration = Duration(seconds: 1);

    if(searchOnStoppedTyping != null){
      setState(()=>searchOnStoppedTyping.cancel());
    }
    setState(()=>
      searchOnStoppedTyping = new Timer(duration, (){
        if(searchController.text.isNotEmpty){
          setState(() {
            _onSearch = true;
            search = input;
          });
        }else{
          setState(() {
            _onSearch = false;
          });
        }
        restoList = fetchRestaurantByCategory(category: widget.category, name: input);
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: new Row(
          children: <Widget>[
            IconButton(
              onPressed: onWillPopButton,
              icon: Icon(Icons.arrow_back_ios),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(right:20.0),
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: new BoxDecoration(
                    color: Color(0xFFf0f0f0),
                    borderRadius: BorderRadius.circular(8)),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: searchController,
                        textCapitalization: TextCapitalization.sentences,
                        style: new TextStyle(fontSize: 14),
                        onChanged: onChange,
                        autofocus: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 8),
                            fillColor: Color(0xFFf0f0f0),
                            border: InputBorder.none,
                            hintText: widget.category),
                      ),
                    ),
                    _onSearch
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.clear();
                                _onSearch = false;
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black38,
                            ))
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onWillPop,
          child: searchBody(),
        ),
      )
    );
  }

  Widget searchBody(){
    return new FutureBuilder<List<Restaurant>>(
      future: restoList,
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<Restaurant> data = snapshot.data;
          return new RestaurantList(restoList: data);
        }
        return CircularProgressIndicator();
      },
    );
  }
}