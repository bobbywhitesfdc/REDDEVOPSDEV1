/**
* @class TestUtil
  @Author Bobby White
  @Date November 4, 2016
  
  This class has a series of reusable methods for common operations in Unit Tests
 **/
@isTest
public class TestUtil {

    public static User createTestUser(String userNameTarget) {
                
        Profile theProfile = [SELECT Id from Profile Where Name='Sales User']; 
        
        User myTestUser = new User(FirstName='Test'
                           ,LastName='User'
                           ,Email='test@example.com'
                           ,Username=userNameTarget
                           ,CommunityNickname='testuser'
                           ,Alias='testu'
                           ,TimeZoneSidKey='America/New_York'
                           ,LocaleSidKey='en_US'
                           ,EmailEncodingKey='ISO-8859-1'
                           ,LanguageLocaleKey='en_US'
                           ,ProfileId=theProfile.id);
        insert myTestUser; 
        
        User testUser = [SELECT Id,Name,Username,Email From User where Alias='testu' LIMIT 1];
        return testUser;
    }
}