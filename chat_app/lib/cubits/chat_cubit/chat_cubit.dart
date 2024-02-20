import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAt: DateTime.now(),
        kId: email,
      });
    } on Exception catch (e) {
      print('$kError $e');
    }
  }

  void getMessage() {
    try {
      messages
          .orderBy(kCreatedAt, descending: true)
          .snapshots()
          .listen((event) {
        List<Message> messagesList = [];
        for (var doc in event.docs) {
          messagesList.add(Message.fromJson(doc));
        }
        emit(ChatSuccess(messagesList: messagesList));
        print('i get it');
      });
    } on Exception catch (e) {
      print('$kError $e');
    }
  }
}
