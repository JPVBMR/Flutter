import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    /* required this.lstOfMessages */
  });

  @override
  Widget build(BuildContext context) {
    final loggedUser = FirebaseAuth.instance.currentUser!;

    /* Creates a listener to the "chat" collection that automatically notify our app when a doc is added  */
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true, //combined with the reverse on the list builder
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages yet'),
          );
        }

        /* LIST OF MESSAGES */
        final lstLoadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true, //Push the list to the bottom of the screen
          itemCount: lstLoadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = lstLoadedMessages[index].data();
            final nextChatMessage = index + 1 < lstLoadedMessages.length
                ? lstLoadedMessages[index + 1]
                : null;

            final currentMessage_userId = chatMessage['userId'];
            final nextMessage_userId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = currentMessage_userId == nextMessage_userId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: loggedUser.uid == currentMessage_userId,
              );
            } else {
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: loggedUser.uid == currentMessage_userId,
              );
            }
          },
        );
      },
    );
  }
}
