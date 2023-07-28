const functions = require("firebase-functions");
const admin = require('firebase-admin');
const { getDownloadURL } = require('firebase-admin/storage');

admin.initializeApp();

const db = admin.firestore();
const storage = admin.storage();

// Storageに画像が追加されたらFirestoreにdownloadUrlを保存
exports.onUploadImage = functions.region('asia-northeast1').storage
  .object()
  .onFinalize(async (object, _) => {
    const bucket = object.bucket;
    const name = object.name;
    const userID = name.split(/[/.]/)[1];

    const fileRef = storage.bucket(bucket).file(name);
    const downloadURL = await getDownloadURL(fileRef);
    
    return db.collection('users').doc(userID).update({
        icon_url: downloadURL
    });
  })