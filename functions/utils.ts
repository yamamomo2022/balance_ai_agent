
import {CallableRequest, HttpsError} from "firebase-functions/v2/https";

/**
 * Wraps a handler function with error handling for Firebase Callable functions.
 * Logs errors and throws a standardized HttpsError on failure.
 *
 * @template T The return type of the handler function.
 * @param {function(CallableRequest): Promise<T>} handler
 *   The async handler function to wrap.
 * @return {function(CallableRequest): Promise<T>}
 *   A new function with error handling.
 */
export function withErrorHandler<T>(
  handler: (request: CallableRequest) => Promise<T>
) {
  return async (request: CallableRequest) => {
    try {
      return await handler(request);
    } catch (error) {
      console.error("Function error:", error);
      throw new HttpsError("internal", "Function process failed.", error);
    }
  };
}
