import { z } from "genkit";
import ai from "../genkit";

const chatPrompt = ai.prompt<z.ZodTypeAny, z.ZodTypeAny>(`chat`)

export const chatFlow = ai.defineFlow(
  {
    name: `chat`,
    inputSchema: z.object({
      message: z.string(),
    }),
    outputSchema: z.object({
      response: z.string(),
    }),
  },
  async (input) => {
    const { output } = await chatPrompt(input)
    return output
  }
)