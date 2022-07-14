import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class AddUserToRoom extends StatelessWidget {
  CollectionReference RoomCollection = Firestore.instance.collection('Room');
  CollectionReference UserCollection = Firestore.instance.collection('users');

  Future<List<Document>> getusers() async {
    List<Document> user = await UserCollection.orderBy('uid').get();
    return user;
  }

  late var room;
  AddUserToRoom(this.room);
  updateGrocery(String groceryName) async {
    print(room.toString().split('/')[2].split(" "));
    List<dynamic> names = room['Arr'];
    print(names);
    names = names.toList();
    names.add(groceryName);

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
    updateGrocery('Abo teraka');
    return Container(
      child: Text("check"),
    );
  }
}
