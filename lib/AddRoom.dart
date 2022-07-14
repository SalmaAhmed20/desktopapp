import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Firestore.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "AddRoom";

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  CollectionReference RoomCollection = Firestore.instance.collection('Room');

  @override
  final _addKey = GlobalKey<FormState>();
  String _camraIP = '';
  String _floorNumber = '';
  String _roomName = '';
  bool isLoading = false;

  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      Center(
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              "images/Artboard 1.png",
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.modulate,
            )),
          ],
        ),
      ),
      Scaffold(
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
          backgroundColor: Colors.transparent,
          body: Form(
            key: _addKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(200, 20, 200, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _camraIP = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Camera IP",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(12, 2, 114, 1)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter camraIP';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _floorNumber = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Floor Number",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(12, 2, 114, 1)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter floorNumber';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _roomName = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Room Name",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(12, 2, 114, 1)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter roomName';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //bugs
                  isLoading
                      ? CircularProgressIndicator()
                      : Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(12, 2, 114, 1),
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            onPressed: () {
                              CreateRoom();
                            },
                            child: Text(
                              "Add Room",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ))
    ]);
  }

  void CreateRoom() {
    if (_addKey.currentState?.validate() != null) {
      RegisterRoom();
    }
  }

  void RegisterRoom() async {
    setState(() {
      this.isLoading = true;
    });
    await RoomCollection.add({
      'name': this._roomName,
      'CamIP': this._camraIP,
      'floorid': this._floorNumber
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: 'Room Added Successfully', toastLength: Toast.LENGTH_LONG);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FireStoreHome()));
    });
  }

  void ShowMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message,
                style: TextStyle(
                    fontFamily: "Poppins", color: Colors.black, fontSize: 18)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FireStoreHome()),
                    );
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }
}

_labels(String label) {
  return Center(
    child: Text(
      label,
      style: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
    ),
  );
}
