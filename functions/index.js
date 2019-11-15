const functions = require('firebase-functions');
const admin = require('firebase-admin');

const serviceAccount = require("./adminsdk.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://long-life-burnning.firebaseio.com"
});

const db = admin.firestore();
const fcm = admin.messaging();

exports.sendUpdateEventNotification = functions.firestore
  .document('Blog/{eventId}')
  .onUpdate(async () => {});

exports.sendCreateEventNotification = functions.firestore
  .document('Blog/{eventId}')
  .onCreate(async snapshot => {
    const data = snapshot.data();
    const tokens = [];
    await db
      .collection('users')
      .get()
      .then(async snapshot => {
        snapshot.docs.map(async docs => {
          await db
            .collection('users')
            .doc(docs.id)
            .collection('token')
            .get()
            .then(snap => {
              if (!snap.empty) tokens.push(snap.docs.map(doc => doc.id));
            });
        });
      });
    const payload = {
      notification: {
        title: 'New Event',
        body: `Event: ${data.title}`,
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
      }
    };
    return fcm.sendToDevice(tokens, payload);
  });
