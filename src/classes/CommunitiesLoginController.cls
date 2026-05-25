/**
 * Apex page controller that exposes the community site login functionality.
 *
 * Security improvements (WO-029):
 *  - startUrl sanitised: only relative URLs forwarded; absolute/null inputs
 *    result in a redirect to the site's root to prevent open-redirect attacks.
 *  - displayType sanitised: only the known values accepted by
 *    Network.forwardToAuthPage are passed through; unknown values default to null.
 *  - Class kept 'global with sharing' for community compatibility.
 */
global with sharing class CommunitiesLoginController {

    private static final Set<String> ALLOWED_DISPLAY_TYPES =
        new Set<String>{ 'page', 'popup', 'touch', 'mobile' };

    global CommunitiesLoginController() {}

    global PageReference forwardToAuthPage() {
        String startUrl     = sanitiseStartUrl(
            System.currentPageReference().getParameters().get('startURL')
        );
        String displayType  = sanitiseDisplayType(
            System.currentPageReference().getParameters().get('display')
        );
        return Network.forwardToAuthPage(startUrl, displayType);
    }

    // -------------------------------------------------------------------------
    // Input sanitisation helpers
    // -------------------------------------------------------------------------

    @TestVisible
    static String sanitiseStartUrl(String rawUrl) {
        if (String.isBlank(rawUrl)) {
            return '/';
        }
        // Accept only relative URLs (must start with '/') to prevent open redirect
        if (!rawUrl.startsWith('/')) {
            return '/';
        }
        return rawUrl;
    }

    @TestVisible
    static String sanitiseDisplayType(String rawDisplay) {
        if (String.isBlank(rawDisplay)) {
            return null;
        }
        return ALLOWED_DISPLAY_TYPES.contains(rawDisplay.toLowerCase())
            ? rawDisplay.toLowerCase()
            : null;
    }
}
