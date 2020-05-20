import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mesan_mobile/common/widgets/Container.dart';
import 'package:mesan_mobile/common/widgets/PinInputField.dart';
import 'package:mesan_mobile/common/routes/Routers.dart';

class VerifyOTP extends StatefulWidget {
  final String phoneNumber;
  VerifyOTP({@required this.phoneNumber});
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final _controller = TextEditingController();
  bool isValid = false;
  String pin = "";
  Timer _timer;
  int _totalTime = 90;
  int _timeRemaining = 0;
  bool timerHasFinished = false;

  @override
  void initState(){
    _timeRemaining = _totalTime;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          MainContainer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Enter Verification Code',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: InputPin(
                        total: 4, 
                        controller: _controller,
                        onChanged: (val)=>setState((){
                          pin = val;
                          isValid = val.length >= 4;
                        }),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          child: timerHasFinished? resendCode():Text(timerString),
                    ),
                      ),)
                  ],
                ),
              )
            ],
          )),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: SizedBox.expand(
                      child: FlatButton(
                        onPressed: isValid
                            ? () {
                                Navigator.pushNamedAndRemoveUntil(context, mainRoute, (Route<dynamic> route) => false);
                              }
                            : null,
                        child: Text('Continue'),
                        color: Colors.red,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  //Text for showing current timer
  String get timerString{
    var duration = Duration(seconds: _timeRemaining);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  //Function to decrement timer
  void _getTime() {
    setState(() {
      if(_timeRemaining == 0){
        _timeRemaining = 0;
        timerHasFinished = true;
      }else{
        _timeRemaining--;
      }
    });
  }

  //Widget to show resend code when timer has finished
  Widget resendCode(){
    return GestureDetector(
      onTap: (){
        setState(() {
          timerHasFinished = false;
          _timeRemaining = _totalTime;
        });
      },
      child: Text('Resend Code'),
    );
  }
}
