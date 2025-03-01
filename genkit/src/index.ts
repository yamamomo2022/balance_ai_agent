import { genkit, z } from "genkit";
import { vertexAI } from "@genkit-ai/vertexai";
import { logger } from "genkit/logging";
import express, { Request, Response, NextFunction } from "express";
import * as admin from 'firebase-admin';
import path from 'path';
import helmet from 'helmet';

// Firebaseの初期化
const serviceAccount = require(path.resolve(__dirname, '../service-account-key.json'));
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// 独自の Express インスタンスを作成し、JSON パーサーを適用
const app = express();
app.use(express.json());
app.use(helmet());

const ai = genkit({ plugins: [vertexAI()] });
logger.setLogLevel("debug");

// 認証ミドルウェアの型定義（必要に応じて拡張可能）
interface AuthenticatedRequest extends Request {
  user?: admin.auth.DecodedIdToken;
}

// 認証ミドルウェア
const checkAuth = (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;
  if (authHeader && authHeader.startsWith('Bearer ')) {
    const idToken = authHeader.split('Bearer ')[1];
    admin
      .auth()
      .verifyIdToken(idToken)
      .then((decodedToken) => {
        req.user = decodedToken;
        next();
      })
      .catch((error) => {
        console.error('トークンの検証エラー:', error);
        res.status(401).send('認証に失敗しました。');
      });
  }
};

// 認証が必要なテストエンドポイント
app.post('/chat', checkAuth, async (req: AuthenticatedRequest, res: Response) => {
  try {
    const input = req.body.data;    
    console.log(`認証済みユーザーからのリクエスト`);
    
    // フローを実行
    const result = await chatFlow.run(input);
    
    // レスポンスを返す
    res.json(result);

  } catch (error) {
    console.error('Error in test-chat endpoint:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});


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

// サーバー起動
const PORT = process.env.PORT || 4300;
app.listen(PORT, () => {
  console.log(`サーバーがポート ${PORT} で起動しました。`);
});
