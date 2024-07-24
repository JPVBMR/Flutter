import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final _firebaseAuth = FirebaseAuth.instance;

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() {
    // TODO: implement createState
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  var _isLoginMode = true;

  /* FORM VALUES */
  var _isAuthenticating = false;

  final _formGlobalKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredUsername = '';
  var _enteredPassword = '';

  File? _selectedImage;
  Uint8List? _selectedImageBytesWEB;

  void _submitForm() async {
    final isFormValid = _formGlobalKey.currentState!.validate();
    if (!isFormValid) return;

    if (!_isLoginMode &&
        _selectedImage == null &&
        _selectedImageBytesWEB == null) return;

    /* Triggers the onSave method of the Form Fields */
    _formGlobalKey.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      /* Differentiate between Login & Register */
      if (_isLoginMode) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      } else {
        /* Register the new user in the Firebase w/ Email & Pass */
        final userCrendetialsResponse =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        print(userCrendetialsResponse.toString());

        /* Save Uploaded Image File into Firebase and create folder - user_images/userId.jpg */
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCrendetialsResponse.user!.uid}.jpg');

        /* SAVE FILE BASE ON DEVICE PLATFORM (WEB or MOBILE) */
        if (kIsWeb) {
          // Web
          if (_selectedImageBytesWEB != null) {
            await storageRef.putData(_selectedImageBytesWEB!);
          }
        } else {
          // Mobile
          if (_selectedImage != null) {
            await storageRef.putFile(_selectedImage!);
          }
        }

        final imageURL =
            await storageRef.getDownloadURL(); //URL TO DISPLAY THE STORED IMAGE

        /**  
        *  FirebaseFirestore.collection gets or creates a collection if it doesnt exist
        *  .doc() Creates a new document in the collection with the Id of the user as "name" 
        *  .set() Data to be stored 
        *   [android/app]  
        **/

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCrendetialsResponse.user!.uid)
            .set(
          {
            "username": _enteredUsername,
            "email": _enteredEmail,
            "image_url": imageURL,
          },
        );
      }
    } on FirebaseAuthException catch (error) {
      /* Custom Error Handling Based on Firebase Response */
      if (error.code == 'email-already-in-use') {}
      /* Show Toast */
      _showToast(error.message ?? 'Register failed. Please try again later');
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  'assets/logo_small.jpg',
                ),
              ),
              Card(
                color: Color.fromARGB(216, 255, 255, 255),
                elevation: 1.5,
                margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    /* FORM BEGIN  */
                    child: Form(
                      key: _formGlobalKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /* REGISTER MODE: UPLOAD PROFILE PIC  */
                          if (!_isLoginMode)
                            UserImagePicker(
                              selectImageFN:
                                  (pickedImageMOBILE, pickedImageBytesWEB) {
                                _selectedImage = pickedImageMOBILE;
                                _selectedImageBytesWEB = pickedImageBytesWEB;
                              },
                            ),

                          /* EMAIL ADDRESS */
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                            },
                            onSaved: (newEmailValue) {
                              _enteredEmail = newEmailValue!;
                            },
                          ),

                          /* USERNAME [REGISTER MODE]*/
                          if (!_isLoginMode)
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                              ),
                              autocorrect: false,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim().length < 5) {
                                  return 'Please enter a username with at least 5 characters';
                                }
                                return null;
                              },
                              onSaved: (newUsernameValue) {
                                _enteredUsername = newUsernameValue!;
                              },
                            ),

                          /* PASSWORD */
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                            },
                            onSaved: (newPasswordValue) {
                              _enteredPassword = newPasswordValue!;
                            },
                          ),

                          /* BUTTONS SECTION */
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /* Button w/ spinner on loading */
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 1, 34, 2)),
                                onPressed:
                                    _isAuthenticating ? null : _submitForm,
                                child: _isAuthenticating
                                    ? const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        _isLoginMode ? 'Login' : 'Sign Up',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 7),
                              TextButton(
                                onPressed: () {
                                  if (_isAuthenticating) return;
                                  setState(() {
                                    _isLoginMode = !_isLoginMode;
                                  });
                                },
                                child: Text(
                                  _isLoginMode
                                      ? 'Don\'t have an account?'
                                      : 'Already have an account?',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 1, 34, 2)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
