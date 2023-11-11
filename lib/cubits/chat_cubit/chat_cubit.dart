import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_states.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  List<Message> MessageList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionMessages);
  void sendMessage({required String text, required String userId}) {
    messages.add({'text': text, 'createdAt': DateTime.now(), 'userId': userId});
  }

  void getMessages() {
    emit(ChatLoadingState());

    messages.orderBy("createdAt", descending: true).snapshots().listen((event) {
      MessageList.clear();
      MessageList.addAll(List<Message>.generate(
          event.docs.length, (i) => Message.formJson(event.docs[i])));
      emit(ChatSuccessState());
    });
  }
}
