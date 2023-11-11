class Message {
  String text;
  String userId;

  Message(this.userId,this.text);

  factory Message.formJson(data) {
    return Message(data['userId'],data['text']);
  }
}
