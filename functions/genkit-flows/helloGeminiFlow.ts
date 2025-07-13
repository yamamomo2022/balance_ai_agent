import { ai } from '../genkit';
import { z } from 'genkit';

export const helloGemini = ai.defineFlow(
    {
        name: `hello-Gemini`,
        inputSchema: z.object({
            text: z.string(),
        }),
        outputSchema: z.object({
            text: z.string(),
        }),
    },
    async (input) => {

        const helloGeminiPrompt = ai.prompt("helloGemini");
        const response = await helloGeminiPrompt(input);
        const output = { text: response.text };
        return output;
    }
)
