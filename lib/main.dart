import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'Firestore.dart';

const apiKey = 'AIzaSyDdZSh6ERaeBnWNjPCHcY8bissjxXHjIqY';
const ProjectId = 'login-276e2';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize(ProjectId);
  runApp(const FireStoreApp());
}
