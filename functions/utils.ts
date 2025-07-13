import { CallableRequest, HttpsError } from 'firebase-functions/v2/https';

export function withErrorHandler<T>(
    handler: (request: CallableRequest) => Promise<T>
) {
    return async (request: CallableRequest) => {
        try {
            return await handler(request);
        } catch (error) {
            console.error('Function error:', error);
            throw new HttpsError('internal', 'Function process failed.', error);
        }
    };
}
