import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import 'AddRoom.dart';
import 'AddUser.dart';
import 'RoomDetails.dart';

class FireStoreApp extends StatelessWidget {
  const FireStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FireStoreHome(),
    );
  }
}

class FireStoreHome extends StatefulWidget {
  const FireStoreHome({Key? key}) : super(key: key);

  @override
  _FireStoreHomeState createState() => _FireStoreHomeState();
}

class _FireStoreHomeState extends State<FireStoreHome> {
  CollectionReference RoomCollection = Firestore.instance.collection('Room');
  CollectionReference UserCollection = Firestore.instance.collection('users');

  final textController = TextEditingController();
  String? selectedId;

  Future<List<Document>> getRoom() async {
    List<Document> Room = await RoomCollection.orderBy('floorid').get();
    return Room;
  }

  Future<List<Document>> getusers() async {
    List<Document> user = await UserCollection.orderBy('uid').get();
    return user;
  }

  // addGrocery(String groceryName) async {
  //   await groceryCollection.add({
  //     'name': groceryName,
  //   });
  // }
  //
  // updateGrocery(String groceryName) async {
  //   await groceryCollection.document(selectedId!).update({
  //     'name': groceryName,
  //   });
  // }
  //
  // deleteGrocery() async {
  //   await groceryCollection.document(selectedId!).delete();
  // }

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
      body: Row(
        children: [
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color.fromRGBO(12, 2, 114, 1),
                    bottom: TabBar(
                      tabs: [
                        Tab(
                            child: Text(
                          'List of Rooms',
                          style: TextStyle(fontSize: 25),
                        )),
                        Tab(
                            child: Text(
                          'List of Users',
                          style: TextStyle(fontSize: 25),
                        )),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Scaffold(
                        floatingActionButton: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddRoomScreen()),
                            );
                          },
                          child: Icon(Icons.add_business),
                        ),
                        body: FutureBuilder<List<Document>>(
                          future: getRoom(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Document>> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading...'));
                            }

                            return snapshot.data!.isEmpty
                                ? const Center(child: Text('No Rooms in List'))
                                : ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: snapshot.data!.map((Room) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push<void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        RoomDetails(Room),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Text(
                                              Room['name'],
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Icon(
                                              Icons.meeting_room,
                                              size: 40,
                                              color: Colors.red,
                                            ),
                                            trailing: Text(
                                              "Floor no ${Room['floorid']}",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      12, 2, 114, 1),
                                                  fontSize: 30),
                                            ),
                                            onTap: () {
                                              Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        RoomDetails(Room),
                                                  ));
                                            },
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                          },
                        ),
                      ),
                      Scaffold(
                        floatingActionButton: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddUserScreen()),
                            );
                          },
                          child: Icon(Icons.person_add),
                        ),
                        body: FutureBuilder<List<Document>>(
                          future: getusers(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Document>> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading...'));
                            }

                            return snapshot.data!.isEmpty
                                ? const Center(
                                    child: Text('No Users in System'))
                                : ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: snapshot.data!.map((user) {
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.push<void>(
                                          //     context,
                                          //     MaterialPageRoute<void>(
                                          //       builder: (BuildContext context) =>
                                          //           RoomDetails(Room),
                                          //     ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Text(
                                              user['firstName'] +
                                                  " " +
                                                  user['secondName'],
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            leading: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.red,
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                          },
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
