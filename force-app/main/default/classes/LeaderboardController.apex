public with sharing class LeaderboardController {

  @AuraEnabled(cacheable=true)
  public static List<Trailhead_User__c> getByType(String leaderboard) {
      
    List<Trailhead_User__c> users = [SELECT Id,Name,trailheadapp__Avatar__c,trailheadapp__External_Id__c,
            trailheadapp__Profile_URL__c,trailheadapp__Profile_Visibility__c,
            trailheadapp__Rank__c,trailheadapp__Total_Points__c,
            trailheadapp__User__c 
            FROM trailheadapp__Trailhead_User__c 
    WHERE trailheadapp__Leaderboards__c includes (:leaderboard)
            ORDER BY Total_Points__c DESC
            LIMIT 5];
    
    // this is a hack... for the hackathon
    for (Trailhead_User__c user : users) {
      user.Completed__c = [SELECT count() FROM User_Badge__c where Status__c = 'Completed' and User__c = :user.User__c];
      user.In_Progress__c = [SELECT count() FROM User_Badge__c where Status__c = 'In-Progress' and User__c = :user.User__c];
    }
    
    return users;
  }
    
}