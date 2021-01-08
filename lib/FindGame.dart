import 'package:pratikum4/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Detail.dart';
import 'Model/Person.dart';

class FindGame extends StatefulWidget {
  @override
  _FindGameState createState() => _FindGameState();
}

class _FindGameState extends State<FindGame> {
  List<Person> _personList = [];

  Future<List<Person>> get getGame async {
    final resp =
        await http.get("https://elephant-api.herokuapp.com/elephants/sex/male");
    if (resp.statusCode != 200) {
      throw ("gagal Terhubung dengan server (Code: ${resp.statusCode}");
    }
    final dynamic res = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      res.forEach((dynamic data) {
        _personList.add(Person.fromJson(jsonEncode(data)));
      });
      return _personList;
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 248, 253, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Transform.translate(
                offset: Offset(15, -15),
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    shape: BoxShape.circle,
                    color: Colors.deepOrange[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // FadeAnimation(
              //     1,
              //     Container(
              //       padding: EdgeInsets.symmetric(vertical: 5),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(50),
              //           color: Colors.white),
              //       child: TextField(
              //         decoration: InputDecoration(
              //             border: InputBorder.none,
              //             prefixIcon: Icon(
              //               Icons.search,
              //               color: Colors.grey,
              //             ),
              //             hintText: "Search Game",
              //             hintStyle: TextStyle(color: Colors.grey)),
              //       ),
              //     )),
              // SizedBox(
              //   height: 30,
              // ),
              Expanded(
                child: FutureBuilder<List<Person>>(
                  initialData: _personList,
                  future: getGame,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done &&
                          snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Person _modelPerson = snapshot.data[index];
                            return Container(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detail(
                                        dataDetail: _modelPerson,
                                      ),
                                    )),
                                child: Column(
                                  children: [
                                    FadeAnimation(
                                      1.5,
                                      makeItem(
                                        image: _modelPerson.image,
                                        title: _modelPerson.name,
                                        genre: _modelPerson.sex +
                                            " - " +
                                            _modelPerson.species,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        print(snapshot.data.length);
                        return Container();
                      }
                    } else {
                      return Container(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeItem({image, title, genre}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.1),
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.airplay_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        genre,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
