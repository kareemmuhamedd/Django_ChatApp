import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String routeName = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  List<Message> messagesList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/chat.png'),
            const Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messagesList;
                }
              },
              builder: (context, state) => ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: messagesList.length,
                itemBuilder: (BuildContext context, index) {
                  return Align(
                    alignment: messagesList[index].id == userEmail
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: messagesList[index].id == userEmail
                        ? ChatBubble(
                            message: messagesList[index],
                          )
                        : ChatBubbleFriend(message: messagesList[index]),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: TextField(
              controller: _textController,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: userEmail);
                _textController.clear();
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                );
              },
              decoration: InputDecoration(
                  hintText: 'Send Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    color: kPrimaryColor,
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      //print('data is    ${snapshot.data?.docs[0][0]}');
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
