import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    super.key,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final messageStr = _messageController.value.text;
    print('$messageStr ###');
    if (messageStr.trim().isEmpty) {
      return;
    }

    /* Close the keyboard & CLEAR MESSAGE INPUT  */
    FocusScope.of(context).unfocus();
    _messageController.clear();

    /* [SEND MESSAGE TO FIREBASE COLLECTION "chat"] 
    *  FirebaseAuth provides the userID of the current user
    *   .doc(name).get() - gets the record from "users" collection
    *   .add() creates a new document with automatic unique name generated by Firebase
    */
    final loggedUser = FirebaseAuth.instance.currentUser!;

    final loggedUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUser.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': messageStr,
        'createdAt': Timestamp.now(),
        'userId': loggedUser.uid,
        'username': loggedUserData.data()!['username'],
        'userImage': loggedUserData.data()!['image_url'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(onPressed: _sendMessage, icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
