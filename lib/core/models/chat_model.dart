import 'package:flutter/cupertino.dart';

class ChatMessage {
  final messageContent;
  final name;
  final time;
  final messageType;
  ChatMessage({this.messageContent, this.messageType, this.time, this.name});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
      time: "10:00 am",
      name: "Kristin Watson"),
  ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
      time: "10:00 am",
      name: "Kristin Watson"),
  ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
      time: "10:00 am",
      name: "Kristin Watson"),
  ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
      time: "10:00 am",
      name: "Kristin Watson"),
  ChatMessage(
      messageContent: "How have you been?",
      messageType: "receiver",
      time: "10:00 am"),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      time: "10:00 am",
      messageType: "sender"),
  ChatMessage(
      messageContent: "ehhhh, doing OK.",
      messageType: "receiver",
      time: "10:00 am"),
  ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageType: "sender",
      time: "10:00 am"),
];
