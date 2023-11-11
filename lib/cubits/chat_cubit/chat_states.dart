import 'package:chat_app/models/message.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatSuccessState extends ChatState {}
class ChatLoadingState extends ChatState {}
