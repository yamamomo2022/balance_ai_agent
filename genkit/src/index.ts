import { z } from "genkit";
import app, { checkAuth, AuthenticatedRequest } from "./app";
import ai from "./genkit";



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
    const prompt = `You are a helpful assistant conversing in Japanese. You MUST respond with a JSON object that has the following structure: { "response": "your response here" }. Do not include any other text.\n
User: ${input.message}
Assistant:`;

    const response = await ai.generate({
      model: "vertexai/gemini-1.5-flash",
      prompt: prompt,
      config: {
        temperature: 0.7,
      },
      output: {
        format: "text",
      },
    });

    console.log("Chat Response:", response);
    return response.text;
  }
);

// 認証が必要なテストエンドポイント
app.post("/chat", checkAuth, async (req: AuthenticatedRequest, res) => {
  try {
    const userInput = req.body.data;
    console.log("認証済みユーザーからのリクエスト");

    const chatResult = await chatFlow.run(userInput);

    res.json(chatResult);
  } catch (error) {
    console.error("Error in /chat endpoint:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// サーバー起動
const PORT = process.env.PORT || 4300;
app.listen(PORT, () => {
  console.log(`サーバーがポート ${PORT} で起動しました。`);
});