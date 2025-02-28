import { genkit, z } from "genkit";
import { vertexAI } from "@genkit-ai/vertexai";
import { logger } from "genkit/logging";
import { startFlowServer } from "@genkit-ai/express";
import express, { Request, Response, NextFunction } from "express";
import * as admin from 'firebase-admin';
import path from 'path';

// Firebaseの初期化
const serviceAccount = require(path.resolve(__dirname, '../service-account-key.json'));
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// 独自の Express インスタンスを作成し、JSON パーサーを適用
const app = express();
app.use(express.json());

const ai = genkit({ plugins: [vertexAI()] });
logger.setLogLevel("debug");


// 認証ミドルウェア
const authenticateUser = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ error: 'Unauthorized: No token provided' });
    }

    const idToken = authHeader.split('Bearer ')[1];
    try {
      const decodedToken = await admin.auth().verifyIdToken(idToken);
      req.user = decodedToken; // ユーザー情報をリクエストに追加
      next();
    } catch (error) {
      console.error('Error verifying auth token:', error);
      return res.status(403).json({ error: 'Unauthorized: Invalid token' });
    }
  } catch (error) {
    console.error('Authentication error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};

// リクエストのTypeScript型拡張
declare global {
  namespace Express {
    interface Request {
      user?: admin.auth.DecodedIdToken;
    }
  }
}

export const chatFlow = ai.defineFlow(
  {
    name: "chat",
    inputSchema: z.preprocess(
      (data) => (typeof data === "string" ? { message: data } : data),
      z.object({
        message: z.string(),
      })
    ),
  },
  async (input) => {
    // チャット用プロンプト例（必要に応じて調整してください）
    const prompt = `You are a helpful assistant conversing in Japanese. You MUST respond with a JSON object that has the following structure: { "response": "your response here" }. Do not include any other text.\n
User: ${input.message}
Assistant:`;
    
    const response = await ai.generate({
      model: `vertexai/gemini-1.5-flash`,
      prompt: prompt,
      config: {
        temperature: 0.7,
      },
      output: {
        format: `text`,
      },
    });

    console.log("Chat Response:", response);
    return response.text;
  }
);

// Express アプリを startFlowServer に渡す
startFlowServer({
  flows: [chatFlow],
  cors: {
    origin: true,
  },
});
