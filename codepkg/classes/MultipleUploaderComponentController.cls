global class MultipleUploaderComponentController {
	private final static Integer DEFAULT_LIMIT = 2000;
	public Integer uploadLimit{get;private set;}
	
    public MultipleUploaderComponentController(){
    	Upload_limit__c uploadLimitSetting = Upload_limit__c.getInstance('Limit');
    	if(uploadLimitSetting!=null && uploadLimitSetting.File_size__c>0){
    		uploadLimit = (Integer)uploadLimitSetting.File_size__c;
    	}else{
    		uploadLimit = DEFAULT_LIMIT;
    	}
    }
    
    @RemoteAction
    global static void deleteCanceled(String[] idList){
    	if(!idList.isEmpty()){
    		delete [SELECT Id FROM ContentDocument WHERE Id IN :idList];
    	}
    }
}