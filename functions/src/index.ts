import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

exports.notificationFunction = functions.firestore
    .document("chat/{message}")
    .onCreate((snapshot, context) => {
      const data = snapshot.data();

      return admin.messaging().sendToTopic("chat", {
        notification: {
          title: data.userName,
          body: data.text,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      });
    });
