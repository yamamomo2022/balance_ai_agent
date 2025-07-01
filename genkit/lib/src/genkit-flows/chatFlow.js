"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.chatFlow = void 0;
const genkit_1 = require("genkit");
const genkit_2 = __importDefault(require("../genkit"));
const chatPrompt = genkit_2.default.prompt(`chat`);
exports.chatFlow = genkit_2.default.defineFlow({
    name: `chat`,
    inputSchema: genkit_1.z.object({
        message: genkit_1.z.string(),
    }),
    outputSchema: genkit_1.z.object({
        response: genkit_1.z.string(),
    }),
}, async (input) => {
    const { output } = await chatPrompt(input);
    return output;
});
//# sourceMappingURL=chatFlow.js.map