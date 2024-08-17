sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ust/nidhisha/practicepurchaseorderapp/test/integration/FirstJourney',
		'ust/nidhisha/practicepurchaseorderapp/test/integration/pages/POsList',
		'ust/nidhisha/practicepurchaseorderapp/test/integration/pages/POsObjectPage',
		'ust/nidhisha/practicepurchaseorderapp/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ust/nidhisha/practicepurchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);