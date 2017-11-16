({
    loadRelatedData : function(component) {

        // Simulated data in this demo
        var harvests = [
            {harvestDate: '09/09/2017', qty: '254 kg', supervisor: '岡本'},
            {harvestDate: '08/05/2017', qty: '201 kg', supervisor: '岡本'},
            {harvestDate: '09/10/2016', qty: '199 kg', supervisor: '岡本'},
            {harvestDate: '09/09/2015', qty: '154 kg', supervisor: '岡本'},
        ];
        component.set("v.harvests", harvests);
        
        var irrigationHistory = [
            {when: '12 時間前', duration: '60 分', volume: '10 リットル'},
            {when: '18 時間前', duration: '30 分', volume: '5 リットル'},
        ];
        component.set("v.irrigationHistory", irrigationHistory);
    }

})