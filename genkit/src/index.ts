import { genkit, z } from "genkit";
import { vertexAI } from "@genkit-ai/vertexai";
import { logger } from "genkit/logging";
import { startFlowServer } from "@genkit-ai/express";
import express from "express";

// 独自の Express インスタンスを作成し、JSON パーサーを適用
const app = express();
app.use(express.json());

const ai = genkit({ plugins: [vertexAI()] });
logger.setLogLevel("debug");

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