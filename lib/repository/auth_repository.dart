import 'dart:convert';
import 'package:annoucement_form/constants.dart';
import 'package:annoucement_form/models/error_model.dart';
import 'package:annoucement_form/models/user_models.dart';
import 'package:annoucement_form/repository/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorageRepository: LocalStorageRepository(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  const AuthRepository(
      {required GoogleSignIn googleSignIn,
      required Client client,
      required LocalStorageRepository localStorageRepository})
      : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(
      error: "Some unexpected error occured",
      data: null,
    );
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final UserModel userAccount = UserModel(
          email: user.email,
          name: user.displayName ?? "",
          profilePic: user.photoUrl ?? "",
          uid: '',
          token: '',
        );
        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAccount.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });
        switch (res.statusCode) {
          case 200:
            final newUser = userAccount.copyWith(
                uid: jsonDecode(res.body)['userdata']['_id'],
                token: jsonDecode(res.body)['token']);
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(
      error: "Some unexpected error occured",
      data: null,
    );
    try {
      String? token = await _localStorageRepository.getToken();

      if (token != null) {
        var res = await _client.get(Uri.parse('$host/'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'krm-token': token,
        });
        print(res.body);
        switch (res.statusCode) {
          case 200:
            print("200");
            final newUser = UserModel.fromJson(
              jsonEncode(
                jsonDecode(res.body)['userdata'],
              ),
            ).copyWith(token: token);
            print("data");
            print(newUser);
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepository.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      print(e.toString());
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
