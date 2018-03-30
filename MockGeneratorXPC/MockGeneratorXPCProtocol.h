#import <Foundation/Foundation.h>

@protocol MockGeneratorXPCProtocol

- (void)generateMockFromFileContents:(nonnull NSString *)contents projectURL:(nonnull NSURL *)projectURL line:(NSInteger)line column:(NSInteger)column withReply:(nonnull void(^)(NSArray<NSString *> * _Nullable, NSError * _Nullable))reply;

@end
