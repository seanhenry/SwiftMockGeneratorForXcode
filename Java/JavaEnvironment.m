#import "JavaEnvironment.h"
#import "jni.h"

#if (defined __MINGW32__) || (defined _MSC_VER)
#  define EXPORT __declspec(dllexport)
#else
#  define EXPORT __attribute__ ((visibility("default"))) \
__attribute__ ((used))
#endif

#if (! defined __x86_64__) && ((defined __MINGW32__) || (defined _MSC_VER))
#  define SYMBOL(x) binary_boot_jar_##x
#else
#  define SYMBOL(x) _binary_boot_jar_##x
#endif

extern const uint8_t SYMBOL(start)[];
extern const uint8_t SYMBOL(end)[];

EXPORT const uint8_t*
bootJar(size_t* size)
{
    *size = SYMBOL(end) - SYMBOL(start);
    return SYMBOL(start);
}

void __cxa_pure_virtual(void) { abort(); }

static JavaVM* jvm = NULL; // Cannot recreate a JVM. See http://bugs.java.com/bugdatabase/view_bug.do?bug_id=4712793

@implementation JavaEnvironment {
    JNIEnv* env;
    JavaVMInitArgs args;
    JavaVMOption options[1];
}

+ (instancetype)shared {
    static JavaEnvironment *_self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _self = [[self alloc] init];
    });
    return _self;
}
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        
        jint version = JNI_VERSION_1_2;
        if (jvm == NULL) {
            // <- Add breakpoint here to run 'pr h -s false SIGSEGV'. See https://github.com/SwiftJava/SwiftJava
            args.version = version;
            args.nOptions = 1;
            options[0].optionString = "-Xbootclasspath:[bootJar]";
            args.options = options;
            args.ignoreUnrecognized = JNI_TRUE;
            JNI_CreateJavaVM(&jvm, (void **)&env, &args);
        }
    }
    return self;
}

- (JNIEnv *)env {
    return env;
}


@end
