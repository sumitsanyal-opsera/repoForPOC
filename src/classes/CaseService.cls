public with sharing class CaseService {
    public static Boolean isHighPriority(Case caseRecord) {
        return caseRecord != null &&
            caseRecord.Priority == 'High';
    }

    public static List<Case> filterOpenCases(
        List<Case> cases
    ) {
        List<Case> openCases = new List<Case>();

        if (cases == null) return openCases;

        for (Case caseRecord : cases) {
            if (caseRecord.IsClosed != true) {
                openCases.add(caseRecord);
            }
        }

        return openCases;
    }
}