sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"sony/btp/managepurchaseorder/test/integration/pages/PurchaseOrderSetList",
	"sony/btp/managepurchaseorder/test/integration/pages/PurchaseOrderSetObjectPage",
	"sony/btp/managepurchaseorder/test/integration/pages/POItemsObjectPage"
], function (JourneyRunner, PurchaseOrderSetList, PurchaseOrderSetObjectPage, POItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('sony/btp/managepurchaseorder') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSetList: PurchaseOrderSetList,
			onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
			onThePOItemsObjectPage: POItemsObjectPage
        },
        async: true
    });

    return runner;
});

