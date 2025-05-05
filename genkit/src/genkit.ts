import { genkit} from "genkit";
import { vertexAI } from "@genkit-ai/vertexai";
import { logger } from "genkit/logging";
import { enableFirebaseTelemetry } from "@genkit-ai/firebase";

enableFirebaseTelemetry();

logger.setLogLevel("debug");

const ai = genkit({ plugins: [vertexAI()] });

export default ai;