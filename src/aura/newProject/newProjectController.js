({
	myAction : function(component, event, helper) {
        
	var idx = event.currentTarget.id;
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      "recordId": idx
        });
    navEvt.fire();
}
	
})