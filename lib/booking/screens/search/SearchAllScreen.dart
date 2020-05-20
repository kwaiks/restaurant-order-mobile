import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/api/RestaurantAPI.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/widgets/RestaurantList.dart';

class SearchAllScreen extends StatefulWidget {
  @override
  _SearchAllScreenState createState() => _SearchAllScreenState();
}

class _SearchAllScreenState extends State<SearchAllScreen> {
  TextEditingController searchController;
  Future<List<Restaurant>> restoList;
  Timer searchOnStoppedTyping;

  String search = "";
  bool _onSearch = false;

  @override
  void initState(){
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    if(searchController.text.isNotEmpty || _onSearch){
      searchController.clear();
      setState(() {
        _onSearch = false;
      });
      return false;
    }
    return true;
  }

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
            restoList = fetchRestaurantByName(input);
          });
        }else{
          setState(() {
            _onSearch = false;
          });
        }
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
              onPressed: onWillPop,
              icon: Icon(Icons.arrow_back_ios),
            ),
            Expanded(
              flex: 2,
              child: Container(
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
                        autofocus: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 8),
                            fillColor: Color(0xFFf0f0f0),
                            border: InputBorder.none,
                            hintText: 'Masakan Padang'),
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
          child: _onSearch ? searchBody():emptySearch(),
        ),
      )
    );
  }

  Widget emptySearch(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text('Most Search',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          Container(
              height: 100,
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:10),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(right:10),
                          padding: EdgeInsets.all(8),
                            decoration:
                                BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFe3e3e3)),
                                  borderRadius: BorderRadius.circular(50)
                                  ),
                            child: Text('Nasi Goreng', style: TextStyle(fontSize: 12))),
                            new Container(
                          margin: EdgeInsets.only(right:10),
                          padding: EdgeInsets.all(8),
                            decoration:
                                BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFe3e3e3)),
                                  borderRadius: BorderRadius.circular(50)
                                  ),
                            child: Text('Nasi Bakar', style: TextStyle(fontSize: 12))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:10),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(right:10),
                          padding: EdgeInsets.all(8),
                            decoration:
                                BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFe3e3e3)),
                                  borderRadius: BorderRadius.circular(50)
                                  ),
                            child: Text('Ubi', style: TextStyle(fontSize: 12))),
                            new Container(
                          margin: EdgeInsets.only(right:10),
                          padding: EdgeInsets.all(8),
                            decoration:
                                BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFe3e3e3)),
                                  borderRadius: BorderRadius.circular(50)
                                  ),
                            child: Text('Martabak Bandung', style: TextStyle(fontSize: 12))),
                      ],
                    ),
                  ),
                ],
              )),
              new Text('History',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          Container(
              height: 100,
              child: new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top:10),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(right:10),
                          padding: EdgeInsets.all(8),
                            decoration:
                                BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFe3e3e3)),
                                  borderRadius: BorderRadius.circular(50)
                                  ),
                            child: Text('Nasi Goreng', style: TextStyle(fontSize: 12))),
                            new Container(
                          margin: EdgeInsets.only(right:10),
                          padding: EdgeInsets.all(8),
                            decoration:
                                BoxDecoration(
                                  border: Border.all(width: 1, color: Color(0xFFe3e3e3)),
                                  borderRadius: BorderRadius.circular(50)
                                  ),
                            child: Text('Nasi Bakar', style: TextStyle(fontSize: 12))),
                      ],
                    ),
                  ),
                ]
              )
          )
        ],
      ),
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