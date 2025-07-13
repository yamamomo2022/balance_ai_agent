import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import serviceAccountJson from "./service-account-key.json";
import { CallableRequest } from 'firebase-functions/v2/https'

// Firebaseの初期化（すでに初期化済みなら再初期化しない）
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccountJson as admin.ServiceAccount),
  });
}

export const verifyAuth = (request: CallableRequest): void => {
  if (!request.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User is not authenticated');
  }
};