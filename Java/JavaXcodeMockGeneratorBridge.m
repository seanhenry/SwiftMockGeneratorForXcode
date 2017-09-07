#import "JavaXcodeMockGeneratorBridge.h"
#import "JavaProtocolMethodBridge.h"
#import "jni.h"
#import "JavaEnvironment.h"
#import "JavaProtocolPropertyBridge.h"

@implementation JavaXcodeMockGeneratorBridge {
    jclass xcodeMockGeneratorClass;
    jobject instance;
    JNIEnv *env;
}

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment {
    self = [super init];
    if (self != nil) {
        env = environment.env;
        xcodeMockGeneratorClass = (*env)->FindClass(env, "codes/seanhenry/mockgenerator/xcode/XcodeMockGenerator");
        jmethodID constructor = (*env)->GetMethodID(env, xcodeMockGeneratorClass, "<init>", "()V");
        instance = (*env)->NewObject(env, xcodeMockGeneratorClass, constructor);
    }
    return self;
}

- (void)addProtocolMethod:(JavaProtocolMethodBridge *)method {
    jmethodID methodID = (*env)->GetMethodID(env, xcodeMockGeneratorClass, "add", "(Lcodes/seanhenry/mockgenerator/entities/ProtocolMethod;)V");
    (*env)->CallVoidMethod(env, instance, methodID, method.javaInstance);
}

- (void)addProtocolProperty:(JavaProtocolPropertyBridge *)prop {
    jmethodID methodID = (*env)->GetMethodID(env, xcodeMockGeneratorClass, "add", "(Lcodes/seanhenry/mockgenerator/entities/ProtocolProperty;)V");
    (*env)->CallVoidMethod(env, instance, methodID, prop.javaInstance);
}

- (NSString *)generate {
    jmethodID methodID = (*env)->GetMethodID(env, xcodeMockGeneratorClass, "generate", "()Ljava/lang/String;");
    jstring result = (*env)->CallObjectMethod(env, instance, methodID);
    jboolean shouldCopy = true;
    return [NSString stringWithUTF8String:(*env)->GetStringUTFChars(env, result, &shouldCopy)];
}

@end
