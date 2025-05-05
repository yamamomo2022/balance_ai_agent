import { z } from "genkit";
import ai from "../genkit";

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