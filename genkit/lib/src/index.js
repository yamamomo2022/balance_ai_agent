"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const app_1 = __importStar(require("./app"));
const chatFlow_1 = require("./genkit-flows/chatFlow");
app_1.default.post("/chat", app_1.checkAuth, async (req, res) => {
    try {
        const userInput = req.body.data;
        console.log("認証済みユーザーからのリクエスト");
        const chatResult = await chatFlow_1.chatFlow.run(userInput);
        res.json(chatResult);
    }
    catch (error) {
        console.error("Error in /chat endpoint:", error);
        res.status(500).json({ error: "Internal server error" });
    }
});
// サーバー起動
const PORT = process.env.PORT || 4300;
app_1.default.listen(PORT, () => {
    console.log(`サーバーがポート ${PORT} で起動しました。`);
});
//# sourceMappingURL=index.js.map