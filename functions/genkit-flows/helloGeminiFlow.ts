import {ai} from "../genkit";
import {z} from "genkit";
import {HttpsError} from "firebase-functions/v2/https";

export const helloGemini = ai.defineFlow(
  {
    name: "hello-Gemini",
    inputSchema: z.object({
      text: z.string(),
    }),
    outputSchema: z.object({
      text: z.string(),
    }),
  },
  async (input) => {
    try {
      const helloGeminiPrompt = ai.prompt("helloGemini");
      const response = await helloGeminiPrompt(input);
      const output = {text: response.text};
      return output;
    } catch (error) {
      console.error("Gemini flow failed:", error);
      throw new HttpsError("internal", "Function process failed.", error);
    }
  }
);
