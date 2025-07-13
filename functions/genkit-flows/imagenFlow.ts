import { ai } from '../genkit';
import { z } from 'genkit';

export const helloImagen = ai.defineFlow(
    {
        name: `hello-Imagen`,
        inputSchema: z.object({
            prompt: z.string(),
        }),
        outputSchema: z.object({
            base64Image: z.string(),
            mimeType: z.string(),
        }),
    },
    async (input) => {
        const helloImagenPrompt = ai.prompt("helloImagen");
        const response = await helloImagenPrompt(input);

        const imageUrl = response.media?.url;

        if (!imageUrl) {
            throw new Error('画像の生成に失敗しました。レスポンスに画像URLが含まれていません。');
        }

        try {
            // URLから画像データを取得してbase64に変換
            const imageResponse = await fetch(imageUrl);
            if (!imageResponse.ok) {
                throw new Error(`画像の取得に失敗しました。ステータス: ${imageResponse.status}`);
            }
            const arrayBuffer = await imageResponse.arrayBuffer();
            const base64 = Buffer.from(arrayBuffer).toString('base64');

            return {
                base64Image: base64,
                mimeType: response.media.contentType || 'image/png'
            };
        } catch (error) {
            // Consider logging the original error for debugging purposes.
            // logger.error('Image processing failed', error);
            console.error('Image processing failed:', error);
            throw new Error('画像の取得または処理中に予期せぬエラーが発生しました。');
        }
    }
)