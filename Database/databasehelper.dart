import 'package:cloud_firestore/cloud_firestore.dart';

import '../lib/RoomModel.dart';

CollectionReference<RoomModel> getRoomsCollectionWithConverter() {
  return FirebaseFirestore.instance
      .collection(RoomModel.COLLECTION_NAME)
      .withConverter<RoomModel>(
        fromFirestore: (snapshot, _) => RoomModel.fromJson(snapshot.data()!),
        toFirestore: (Room, _) => Room.toJson(),
      );
}
