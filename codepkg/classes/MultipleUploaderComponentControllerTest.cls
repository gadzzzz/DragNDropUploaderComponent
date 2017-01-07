@isTest
private class MultipleUploaderComponentControllerTest {

    static testMethod void myUnitTest() {
    	MultipleUploaderComponentController cnt = new MultipleUploaderComponentController();
    	
    	Upload_limit__c setting = new Upload_limit__c();
    	setting.File_size__c = 2000;
    	setting.Name = 'Limit';
    	insert setting;
    	
    	cnt = new MultipleUploaderComponentController();
    	
    	System.assertEquals(2000,cnt.uploadLimit);
    	
    	Case caseToInsert = new Case();
    	caseToInsert.status = 'New';
    	caseToInsert.origin = 'Email';
    	insert caseToInsert;
    	
    	ContentVersion file = new ContentVersion();
      	file.Title = 'File';
      	file.PathOnClient = 'File.jpg';
      	file.VersionData = Blob.valueOf('Test Content');
      	file.IsMajorVersion = true;
    	insert file;
    	
    	FeedItem itemToInsert = new FeedItem();
    	itemToInsert.ParentId = caseToInsert.Id;
    	itemToInsert.Title = 'Test file';
    	itemToInsert.RelatedRecordId = file.id;
    	insert itemToInsert;
    	
        String[] isList = new List<String>();
        for(ContentDocument doc_i : [SELECT Id FROM ContentDocument]){
            isList.add(doc_i.Id);
        }
                
    	MultipleUploaderComponentController.deleteCanceled(isList);
        
        System.assertEquals(0,[SELECT count() FROM ContentDocument]);
    	
    }
}