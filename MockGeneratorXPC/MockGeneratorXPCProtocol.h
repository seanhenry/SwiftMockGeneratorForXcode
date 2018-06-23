#import <Foundation/Foundation.h>
@class XPCBufferInstructions;
@class XPCMockGeneratorModel;

@protocol MockGeneratorXPCProtocol

NS_ASSUME_NONNULL_BEGIN

- (void)generateMockFrom:(XPCMockGeneratorModel *)model
               withReply:(void (^)(XPCBufferInstructions *_Nullable, NSError *_Nullable))reply;

#ifdef DEBUG

- (void)crash;

#endif

NS_ASSUME_NONNULL_END

@end
