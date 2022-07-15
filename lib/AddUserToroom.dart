import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import 'Firestore.dart';

class AddUserToRoom extends StatelessWidget {
  CollectionReference RoomCollection = Firestore.instance.collection('Room');
  CollectionReference UserCollection = Firestore.instance.collection('users');

  Future<List<Document>> getusers() async {
    List<Document> user = await UserCollection.orderBy('uid').get();
    return user;
  }

  late var room;
  AddUserToRoom(this.room);
  AddUserr(String userName) async {
    print(room.toString().split('/')[2].split(" "));
    List<dynamic> names = room['Arr'];
    print(names);
    names = names.toList();
    names.add(userName);

    await RoomCollection.document(room.toString().split('/')[2].split(" ")[0])
        .update({
      'name': room['name'],
      'floorid': room['floorid'],
      'CamIP': room['CamIP'],
      'Arr': names,
    });
  }

  @override
  Widget build(BuildContext context) {
    // AddUserr('Abo teraka');
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
              "Choose a User",
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
      body: FutureBuilder<List<Document>>(
        future: getusers(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Loading...'));
          }

          return snapshot.data!.isEmpty
              ? const Center(child: Text('No Users in System'))
              : ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data!.map((user) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          user['firstName'] + " " + user['secondName'],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.red,
                        ),
                        onTap: () {
                          this.AddUserr(user['firstName']);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => FireStoreHome()));
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
    );
  }
}
