"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const genkit_1 = require("genkit");
const vertexai_1 = require("@genkit-ai/vertexai");
const logging_1 = require("genkit/logging");
const firebase_1 = require("@genkit-ai/firebase");
(0, firebase_1.enableFirebaseTelemetry)();
logging_1.logger.setLogLevel("debug");
const ai = (0, genkit_1.genkit)({
    plugins: [(0, vertexai_1.vertexAI)()]
});
exports.default = ai;
//# sourceMappingURL=genkit.js.map