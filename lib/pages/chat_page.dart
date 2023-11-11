import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_states.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static const id = "ChatPage";

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String userId =
        ModalRoute.of(context)!.settings.arguments as String; // or can user var
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/scholar.png"),
              height: 60,
            ),
            Text("  Chat"),
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {

              if (state is ChatLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                );
              }
              var MessageList = BlocProvider.of<ChatCubit>(context).MessageList;
              return ListView.builder(
                  controller: scrollController,
                  reverse: true,
                  itemCount: MessageList.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      content: MessageList[index],
                      isSender: MessageList[index].userId == userId,
                    );
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              TextField(
                controller: controller,
                onSubmitted: (value) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(text: controller.text, userId: userId);
                  controller.clear();
                  GoToEnd();
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                      top: 20, bottom: 20, right: 37, left: 12),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                ),
                cursorColor: kPrimaryColor,
                maxLines: 6,
                minLines: 1,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: 59,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<ChatCubit>(context)
                            .sendMessage(text: controller.text, userId: userId);
                        controller.clear();
                        GoToEnd();
                      },
                      icon: const Icon(Icons.send),
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  void GoToEnd() {
    scrollController.animateTo(
        scrollController.position.minScrollExtent // OR 0
        ,
        duration: Duration(
            milliseconds: scrollController.offset.toInt() > 500
                ? 500
                : scrollController.offset.toInt()),
        curve: Curves.linear);
  }
}

//   return FutureBuilder<DocumentSnapshot>(
//     future: messages.doc("1euDrm17kKEfBZ8gAbgc").get(),
//     builder:
//         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if(snapshot.hasData)
//           {
//             print(snapshot.data); //Instance of '_JsonDocumentSnapshot'
//             print( snapshot.data!.data()); //_Map<String, dynamic> , {text: asdfwwwww}
//           }
//           return Scaffold();
//     },
//   );

// return FutureBuilder<QuerySnapshot>(
//   future: messages.get(),
//   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     if (snapshot.hasData) {

//       print(snapshot); // AsyncSnapshot<QuerySnapshot<Object?>>
//       print(snapshot.data);// Instance of 'JsonQuerySnapshot'
//       print(snapshot.data!.docs);// List<_JsonQueryDocumentSnapshot>
//       print(snapshot.data!.docs[0]);//'_JsonQueryDocumentSnapshot'
//       print(snapshot.data!.docs[0].data());//  Map<String, dynamic> , {text: asdfwwwww}

//     }
//     return Scaffold();
//   });
