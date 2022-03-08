import 'package:carespot/services/authentication_api.dart';
import 'package:carespot/services/db_firestore_api.dart';

class HomeBloc{
  final DbApi dbApi;
  final AuthenticationApi authenticationApi;

  //TODO: Create Streams and Sinks method

  HomeBloc(this.dbApi,this.authenticationApi);

}