import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/widgets/Container.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Fill the form below',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  enableSuggestions: false,
                  decoration: new InputDecoration(
                    hintText: 'Ex: John Smith',
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Full Name',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (value) {},
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  enableSuggestions: false,
                  decoration: new InputDecoration(
                    hintText: 'Ex: john.smith@email.com',
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Email',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (value) {},
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 40.0,
                      width: 50.0,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/indonesia.png'),
                            width: 15,
                            height: 15,),
                          Text('+62',style:TextStyle(fontSize:14)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        enableSuggestions: false,
                        decoration: new InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          hintText: 'Ex: 86312332',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (value){
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: 
                      TextSpan(
                        text: 'By registering you agree to our ',
                        style: new TextStyle(color: Colors.black),
                        children: [TextSpan(
                        text: 'Terms and Condition',
                        style: TextStyle(color: Colors.redAccent),
                        recognizer: new TapGestureRecognizer()..onTap = ()=>print('clicked')
                      )]
                      ),
                )
              )
            ],
          ))
        ]),
      ),
    );
  }
}
