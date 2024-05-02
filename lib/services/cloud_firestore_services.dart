import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_city_traveller/model/sign_up_model.dart';

class CloudFireStoreServices{

  final signUpCollection = FirebaseFirestore.instance.collection('signUp');

  static CloudFireStoreServices instance = CloudFireStoreServices._();
  CloudFireStoreServices._();

  /// user signup
  void signUp({required SignUpModel signUpModel,}){
      signUpCollection.add(signUpModel.toJson()).then((value){
        value.set({'userId': value.id}, SetOptions(merge: true));
      });
  }

  /// credential are same when user login
 Future<String> compareCredential({required String email, required String password,}) async {
    print("email ===> $email");
    print("password ===> $password");
    String name = "";
    return signUpCollection.where(
            Filter.and(
                 Filter('userEmail', isEqualTo: email),
                 Filter('userPassWord', isEqualTo: password),
               ),
            ).get().then((value){
              for (var element in value.docs) {
                name = element.get('userName');
                print("enter");
                print("service name ===> ${element.get('userName')}");
              }
              return name;
           });
 }

}