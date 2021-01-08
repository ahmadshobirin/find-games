import 'package:flutter/material.dart';

import 'Model/Person.dart';

class Detail extends StatefulWidget {
  Detail({Key key, this.dataDetail}) : super(key: key);
  final Person dataDetail;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Person _person = widget.dataDetail;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: NetworkImage(_person.image),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  _person.name.toString().toUpperCase(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Lahir: ${_person.dob.toString()}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Mati: ${_person.dod.toString()}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Catatan:",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  _person.note,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
