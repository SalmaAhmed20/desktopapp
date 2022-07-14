import 'package:desktopapp/AddUserToroom.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';

class RoomDetails extends StatefulWidget {
  late var Room;

  RoomDetails(this.Room);

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  CollectionReference usersCollection = Firestore.instance.collection('users');

  late var user = null;

  getusers() async {
    user = await usersCollection
        .document(widget.Room['users'].toString().split('/')[1])
        .get();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85.0),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(12, 2, 114, 1),
          primary: false,
          leading: const Padding(
            padding: EdgeInsets.fromLTRB(12.0, 7, 0, 0),
            child: Icon(
              Icons.remove_red_eye,
              size: 60,
              color: Colors.red,
            ),
          ),
          flexibleSpace: const Padding(
            padding: EdgeInsets.fromLTRB(80.0, 0, 0, 0),
            child: Text(
              "Catch Danger",
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              maxLines: 2,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(500, 30, 0, 0),
        child: Row(
          children: [
            Card(
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color.fromRGBO(12, 2, 114, 1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'images/Artboard 1.png',
                      width: 300,
                    ), // <-- SEE HERE

                    Text("Room Name :${widget.Room['name']}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 2, 114, 1))),
                    Text("Floor Number: ${widget.Room['floorid']}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 2, 114, 1))),
                    Text("Camera Number: ${widget.Room['CamIP']}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 2, 114, 1))),

                    FutureBuilder<dynamic>(
                        future: getusers(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading...'));
                          }
                          return snapshot.data == null
                              ? const Center(child: Text('No users in List'))
                              : Text("Responsible: ${user['firstName']}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(12, 2, 114, 1)));
                        }),
                    Text("Responsible: ${widget.Room['Arr']}",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(12, 2, 114, 1))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(12, 2, 114, 1)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.blue)))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Go Back",
                                  style: TextStyle(fontSize: 25),
                                )),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromRGBO(12, 2, 114, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.blue)))),
                              onPressed: () {
                                Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          AddUserToRoom(widget.Room),
                                    ));
                              },
                              child: Text("Add User to Room",
                                  style: TextStyle(fontSize: 25)))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
