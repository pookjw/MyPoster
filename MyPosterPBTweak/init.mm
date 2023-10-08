#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <substrate.h>

namespace MP_PBFPosterGalleryPreviewViewController {
	namespace viewDidLoad {
        void (*original)(UIViewController *self, SEL _cmd);
		void custom(UIViewController *self, SEL _cmd) {
        	original(self, _cmd);

            NSMutableArray<UIBarButtonItemGroup *> *leadingItemGroups = [self.navigationItem.leadingItemGroups mutableCopy];

            __block auto unretainedSelf = self;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithPrimaryAction:[UIAction actionWithTitle:[NSString string] image:[UIImage systemImageNamed:@"ant"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
                __kindof UIViewController *viewController = [NSClassFromString(@"ExtensionListViewController") new];
                // viewController.view.backgroundColor = UIColor.systemBackgroundColor;
                [unretainedSelf presentViewController:viewController animated:YES completion:nil];
                [viewController release];
            }]];
            
            UIBarButtonItemGroup *group = [[UIBarButtonItemGroup alloc] initWithBarButtonItems:@[item] representativeItem:nil];
            [item release];
            
            [leadingItemGroups addObject:group];
            [group release];
            
            self.navigationItem.leadingItemGroups = leadingItemGroups;
            [leadingItemGroups release];
        };
	}

	// namespace setDataProvider {
	// 	void (*original)(id self, SEL _cmd, id arg0);
	// 	void custom(id self, SEL _cmd, id arg0) {
	// 		[arg0 release];
	// 		id demoPreviewProvider = reinterpret_cast<id (*)(Class, SEL)>(objc_msgSend)(NSClassFromString(@"PBFPosterGalleryDataProvider"), NSSelectorFromString(@"demoPreviewProvider"));
	// 		original(self, _cmd, [[demoPreviewProvider mutableCopy] autorelease]);
	// 	}
	// }
}

  __attribute__((constructor)) static void init() {
    MSHookMessageEx(
        NSClassFromString(@"_PBFGalleryCollectionViewController"),
        @selector(viewDidLoad),
        reinterpret_cast<IMP>(&MP_PBFPosterGalleryPreviewViewController::viewDidLoad::custom),
        reinterpret_cast<IMP *>(&MP_PBFPosterGalleryPreviewViewController::viewDidLoad::original)
    );

    // MSHookMessageEx(
    //     NSClassFromString(@"_PBFGalleryCollectionViewController"),
    //     NSSelectorFromString(@"setDataProvider:"),
    //     reinterpret_cast<IMP>(&MP_PBFPosterGalleryPreviewViewController::setDataProvider::custom),
    //     reinterpret_cast<IMP *>(&MP_PBFPosterGalleryPreviewViewController::setDataProvider::original)
    // );
  }
