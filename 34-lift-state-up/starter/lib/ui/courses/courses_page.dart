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
import 'package:rwcourses/model/course.dart';
import 'package:rwcourses/repository/course_repository.dart';
import 'package:rwcourses/ui/course_detail/course_detail_page.dart';
import 'package:rwcourses/ui/courses/courses_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _controller = CoursesController(CourseRepository());

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
    return FutureBuilder<List<Course>>(
        future: _controller.fetchCourses(_filterValue),
        builder: (context, snapshot) {
          var courses = snapshot.data;
          if (courses == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: courses.length,
            itemBuilder: (BuildContext context, int position) {
              return _buildRow(courses[position]);
            },
          );
        });
  }

  Widget _buildRow(Course course) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text("${course.name}", style: TextStyle(fontSize: 18.0)),
        ),
        subtitle: Text("${course.domainsString}"),
        trailing: Hero(
          tag: "cardArtwork-${course.courseId}",
          transitionOnUserGestures: true,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              course.artworkUrl,
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CourseDetailsPage(
                course: course,
              ),
            ),
          );
        },
      ),
    );
  }
}
