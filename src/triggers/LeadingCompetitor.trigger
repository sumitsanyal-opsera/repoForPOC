trigger LeadingCompetitor on Opportunity (before insert,before update) {
    
    for(Opportunity opp:Trigger.new){
        //add all prices in a list in order
        List<Decimal> competitorPrices=new List<Decimal>();
        competitorPrices.add(opp.Competitor_1_Price__c);
        competitorPrices.add(opp.Competitor_2_Price__c);
        competitorPrices.add(opp.Competitor_3_Price__c);
        
        //add all competitors in a list in order
        List<String> competitors=new List<String>();
        competitors.add(opp.Competitor_1__c);
        competitors.add(opp.Competitor_2__c);
        competitors.add(opp.Competitor_3__c);
        
        //Loop through all competitors to find position of lowest price
        //Decimal lowestPrice;
        //Integer lowestPricePosition;
        
        //Loop through all competitors to find position of highest price
        Decimal highestPrice;
        Integer highestPricePosition;
        
        for(Integer i=0;i<competitorPrices.size();i++){
           Decimal currentPrice=competitorPrices.get(i);
            if(highestPrice==null || currentPrice>highestPrice){
                highestPrice=currentprice;
                highestPricePosition=i;
            }
            /*if(lowestPrice==null || currentPrice<lowestPrice){
                lowestPrice=currentPrice;
                lowestPricePosition=i;
            }*/  
        }
        opp.Leading_Competitor__c=competitors.get(highestPricePosition);
        opp.Leading_Competitor_Price__c=highestPrice;
        // opp.Leading_Competitor__c=competitors.get(lowestPricePosition);        
    }
    
}