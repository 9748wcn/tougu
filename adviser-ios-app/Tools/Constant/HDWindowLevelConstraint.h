//
//  HDWindowLevelConstraint.h
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/10.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

static inline UIWindowLevel HDPopUpViewWindowLevel(){
    return UIWindowLevelStatusBar+1;
}

static inline UIWindowLevel HDAlertViewWindowLevel(){
    return UIWindowLevelStatusBar+2;
}

static inline UIWindowLevel HDPromptWindowLevel(){
    return UIWindowLevelStatusBar+3;
}

static inline UIWindowLevel HDGestureWindowLevel(){
    return UIWindowLevelStatusBar+4;
}

static inline UIWindowLevel HDAboveGestureWindowLevel(){
    return UIWindowLevelStatusBar+5;
}

static inline UIWindowLevel HDBlockHudWindowLevel(){
    return UIWindowLevelStatusBar+6;
}

static inline UIWindowLevel HDAppGuideWindowLevel(){
    return UIWindowLevelAlert;
}

static inline UIWindowLevel HDAppSplashWindowLevel(){
    return UIWindowLevelAlert+1;
}

static inline UIWindowLevel HDTopWindowLevel(){
    return UIWindowLevelAlert+2;
}
