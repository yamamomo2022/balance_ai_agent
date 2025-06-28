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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkAuth = void 0;
const express_1 = __importDefault(require("express"));
const admin = __importStar(require("firebase-admin"));
const path_1 = __importDefault(require("path"));
const helmet_1 = __importDefault(require("helmet"));
// Firebaseの初期化
const serviceAccount = require(path_1.default.resolve(__dirname, "../service-account-key.json"));
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});
// Express アプリケーションの作成
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.use((0, helmet_1.default)());
// 認証ミドルウェア
const checkAuth = (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith("Bearer ")) {
        const idToken = authHeader.split("Bearer ")[1];
        admin
            .auth()
            .verifyIdToken(idToken)
            .then((decodedToken) => {
            req.user = decodedToken;
            next();
        })
            .catch((error) => {
            console.error("トークンの検証エラー:", error);
            res.status(401).send("認証に失敗しました。");
        });
    }
    else {
        res.status(401).send("認証情報がありません。");
    }
};
exports.checkAuth = checkAuth;
exports.default = app;
//# sourceMappingURL=app.js.map