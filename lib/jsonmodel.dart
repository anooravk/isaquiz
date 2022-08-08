// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.enable,
    required this.quiztitle,
    required this.revision,
    required this.questions,
  });

  String? quiztitle;
  DateTime? revision;
  List<Question>? questions;
  bool? enable;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    enable: json["enable"] == null ? null : json["enable"],
    quiztitle: json["quiztitle"] == null ? null : json["quiztitle"],
    revision: json["revision"] == null ? null : DateTime.parse(json["revision"]),
    questions: json["questions"] == null ? null : List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "enable": enable == null ? null : enable,
    "quiztitle": quiztitle == null ? null : quiztitle,
    "revision": revision == null ? null : revision,
    "questions": questions == null ? null : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  String question;
  List<String>? answers;
  String correctAnswer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    question: json["question"] == null ? null : json["question"],
    answers: json["answers"] == null ? null : List<String>.from(json["answers"].map((x) => x)),
    correctAnswer: json["correct_answer"] == null ? null : json["correct_answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question == null ? null : question,
    "answers": answers == null ? null : List<dynamic>.from(answers!.map((x) => x)),
    "correct_answer": correctAnswer == null ? null : correctAnswer,
  };
}
