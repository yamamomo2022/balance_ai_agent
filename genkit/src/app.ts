import express, { Request, Response, NextFunction } from "express";
import * as admin from "firebase-admin";
import path from "path";
import helmet from "helmet";

// Firebaseの初期化
const serviceAccount = require(path.resolve(__dirname, "../service-account-key.json"));
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Express アプリケーションの作成
const app = express();
app.use(express.json());
app.use(helmet());

// 認証ミドルウェアの型定義
export interface AuthenticatedRequest extends Request {
  user?: admin.auth.DecodedIdToken;
}

// 認証ミドルウェア
export const checkAuth = (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  const authHeader = req.headers.authorization;
  if (authHeader && authHeader.startsWith("Bearer ")) {
    const idToken = authHeader.split("Bearer ")[1];
    admin
      .auth()
      .verifyIdToken(idToken)
      .then((decodedToken) => {
        req.user = decodedToken;
        next();
      })
      .catch((error) => {
        console.error("トークンの検証エラー:", error);
        res.status(401).send("認証に失敗しました。");
      });
  } else {
    res.status(401).send("認証情報がありません。");
  }
};

export default app;