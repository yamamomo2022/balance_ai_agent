import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as path from "path";
import * as fs from "fs";

// サービスアカウントキーのパスを指定して動的に読み込む
const serviceAccountPath = path.join(__dirname, "service-account-key.json");
const serviceAccountJson = JSON.parse(
  fs.readFileSync(serviceAccountPath, "utf8")
);
import {CallableRequest} from "firebase-functions/v2/https";

// Firebaseの初期化（すでに初期化済みなら再初期化しない）
if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(
      serviceAccountJson as admin.ServiceAccount
    ),
  });
}

export const verifyAuth = (request: CallableRequest): void => {
  if (!request.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User is not authenticated"
    );
  }
};
