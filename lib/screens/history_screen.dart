import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_meet/resources/firestore_methods.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  Future<void> _clearHistory(BuildContext context) async {
    try {
      await FirestoreMethods().clearMeetingHistory();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meeting history cleared.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to clear history: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirestoreMethods().meetingsHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              (snapshot.data! as dynamic).docs.isEmpty) {
            return const Center(
              child: Text('No meeting history found.'),
            );
          }

          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              var meeting = (snapshot.data! as dynamic).docs[index];
              return ListTile(
                title: Text('Room Name: ${meeting['meetingName']}'),
                subtitle: Text(
                  'Joined on ${DateFormat.yMMMd().format(meeting['createdAt'].toDate())} at ${DateFormat.jm().format(meeting['createdAt'].toDate())}',
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _clearHistory(context),
        child: const Icon(Icons.delete),
        tooltip: 'Clear History',
        backgroundColor: Colors.blue,
      ),
    );
  }
}
