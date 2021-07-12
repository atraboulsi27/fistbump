import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


void sendEmail(String recipient, String senderName, String recipientName,
    DateTime time, bool mode,
    [bool? decision]) async {
  //mode true: user book -> send mail to trainer
  //mode false: trainer approves or rejects -> send mail to user
  //message must contain time of appointment and name of sender and recipient
  //decision for the professional to decide whether the appointment is accepted or rejected

  final SmtpServer server = gmail("a.traboulsi1@gmail.com", "");
  String message;
  String subject;

  if (mode == true) {
    subject = "Booked appointment by "+senderName;
    message = "Dear " +
        recipientName +
        ",\n\n" +
        senderName +
        " has a pending booked appointment at " +
        time.toString() +
        ".\n\nBest Regards,\nFistbump Team";
  } else {
    subject = "Appointment decision by "+senderName;
    if (decision == true) {
      message = "Dear " +
          recipientName +
          ",\n\n" +
          senderName +
          " has accepted your appointment at " +
          time.toString() +
          ".\n\nBest Regards,\nFistbump Team";
    } else {
      message = "Dear " +
          recipientName +
          ",\n\n" +
          senderName +
          " has rejected your appointment at " +
          time.toString() +
          ".\n\nBest Regards,\nFistbump Team";
    }
  }
  final m = Message()
  ..from = Address("a.traboulsi1@gmail.com", 'Fistbump')
  ..recipients.add(recipient)
  ..subject = subject
  ..text = message;

  await send(m, server);

//  final Email email = Message(
//    body: message,
//    subject: subject,
//    recipients: [recipient],
//    isHTML: false,
//  );
//
//  await FlutterEmailSender.send(email);
}
