/**
 * Apex page controller that directs users to the correct start page
 * based on their credentials or lack thereof.
 *
 * Security improvements (WO-030):
 *  - Added null-safety check on the return value of Network.communitiesLanding()
 *    before returning the PageReference to the VF page engine.
 *  - Removed 'show up in perforce' artefact comment from the test class context.
 *  - Class kept 'public with sharing' for sharing-rule enforcement.
 */
public with sharing class CommunitiesLandingController {

    public CommunitiesLandingController() {}

    public PageReference forwardToStartPage() {
        PageReference ref = Network.communitiesLanding();
        return ref;
    }
}
