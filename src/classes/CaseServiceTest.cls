@IsTest
private class CaseServiceTest {

    @IsTest
    static void testCaseMethods() {

        Case openCase = new Case(
            Subject='Open Case',
            Status='New',
            Priority='High'
        );

        System.assert(
            CaseService.isHighPriority(openCase)
        );

        List<Case> result =
            CaseService.filterOpenCases(
                new List<Case>{openCase}
            );

        System.assertEquals(1, result.size());
    }
}