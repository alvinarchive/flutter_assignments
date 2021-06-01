import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = snapshot.data.documents;
        return ListView.builder(
          itemCount: chatDocs.length,
          reverse: true,
          itemBuilder: (context, index) =>
              MessageBubble(chatDocs[index]['text']),
        );
      },
    );
  }
}
