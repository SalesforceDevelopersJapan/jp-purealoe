({
    toggleChangeHandler : function(component, event) {
        var service = component.find("service");
        service.saveRecord(function(result) {});
    },

    onInit : function(component, event, helper) {
        
        var harvestColumns = [
            {label: '日時', fieldName: 'harvestDate', type: 'text'},
            {label: '数量', fieldName: 'qty', type: 'text'},
            {label: '監督者', fieldName: 'supervisor', type: 'text'}
        ];
        component.set("v.harvestColumns", harvestColumns);

        var irrigationColumns = [
            {label: '日時', fieldName: 'when', type: 'text'},
            {label: '時間', fieldName: 'duration', type: 'text'},
            {label: '量', fieldName: 'volume', type: 'text'}
        ];
        component.set("v.irrigationColumns", irrigationColumns);

        helper.loadRelatedData(component);

    },

    navigateToRecordHome : function(component) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.recordId"),
            "slideDevName": "detail"
        });
        navEvt.fire();
    },

    // A different record was selected
    recordChangeHandler : function(component, event) {
        var id = event.getParam("recordId");
        component.set("v.recordId", id);
        var service = component.find("service");
        service.reloadRecord();
    },

    // The current record was updated by another component
    recordUpdatedHandler : function(component, event) {
        var changeType = event.getParams().changeType;
        if (changeType === "CHANGED") {
            var service = component.find("service");
            service.reloadRecord();
        }    
    },
    
})
