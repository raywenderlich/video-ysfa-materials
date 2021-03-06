//  Copyright (c) 2020 Razeware LLC
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//  distribute, sublicense, create a derivative work, and/or sell copies of the
//  Software in any work that is designed, intended, or marketed for pedagogical or
//  instructional purposes related to programming, coding, application development,
//  or information technology.  Permission for such use, copying, modification,
//  merger, publication, distribution, sublicensing, creation of derivative works,
//  or sale is expressly withheld.
//
//  This project and source code may use libraries or frameworks that are
//  released under various Open-Source licenses. Use of those libraries and
//  frameworks are governed by their own individual licenses.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import 'package:flutter/material.dart';
import 'package:rwcourses/constants.dart';
import 'package:rwcourses/strings.dart';
import 'package:rwcourses/ui/filter/filter_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int _filterValue = Constants.allFilter;

  @override
  void initState() {
    super.initState();

    _loadValue();
  }

  _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _filterValue = prefs.getInt(Constants.filterKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.filter),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FilterWidget(
              value: Constants.iosFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.ios,
            ),
            FilterWidget(
              value: Constants.androidFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.android,
            ),
            FilterWidget(
              value: Constants.flutterFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.flutter,
            ),
            FilterWidget(
              value: Constants.sssFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.sss,
            ),
            FilterWidget(
              value: Constants.unityFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.unity,
            ),
            FilterWidget(
              value: Constants.macosFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.macos,
            ),
            FilterWidget(
              value: Constants.allFilter,
              groupValue: _filterValue,
              onChanged: _handleRadioValueChange,
              text: Strings.all,
            ),
          ],
        ),
      ),
    );
  }

  void _handleRadioValueChange(int value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _filterValue = value;
      prefs.setInt(Constants.filterKey, _filterValue);
    });
  }
}
