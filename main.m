//! \defgroup models Models
//! \defgroup additions Class Additions
//! \defgroup controllers Controllers

/*!
 \ingroup controllers
 \defgroup timer_controllers Timer View Controllers
 */

/*!
 \ingroup controllers
 \defgroup nav_controllers Navigation View Controllers
 */

/*!
 \ingroup controllers
 \defgroup modal_controllers Modal View Controllers
 */

int main(int argc, char *argv[]) {    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
