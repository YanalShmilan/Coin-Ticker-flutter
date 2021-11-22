import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCur = "USD";
  double BTCrate = 99;
  double ETHrate = 99;
  double LTCrate = 99;

  @override
  void getRate(selectedCur) async {
    CoinData coinData = CoinData();
    try {
      var res = await coinData.getData(selectedCur);
      setState(() {
        BTCrate = res[0];
        ETHrate = res[1];
        LTCrate = res[2];
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDrobdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String cur in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(cur),
          value: cur,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCur,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCur = value;
          getRate(selectedCur);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String cur in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(cur),
          value: cur,
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCur = currenciesList[index];
          getRate(selectedCur);
        });
      },
      children: dropdownItems,
    );
  }

  void initState() {
    super.initState();
    getRate(selectedCur);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${BTCrate.toStringAsFixed(2)} $selectedCur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${ETHrate.toStringAsFixed(2)} $selectedCur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${LTCrate.toStringAsFixed(2)} $selectedCur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDrobdownButton() : iOSPicker(),
          ),
        ],
      ),
    );
  }
}
