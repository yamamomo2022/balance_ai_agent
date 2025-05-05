import app, { checkAuth, AuthenticatedRequest } from "./app";
import { chatFlow } from "./genkit-flows/chatFlow";

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