const cds = require('@sap/cds')
const { where, SELECT } = require('@sap/cds/lib/ql/cds-ql')

module.exports = class CatalogService extends cds.ApplicationService {
  init() {

    const { EmployeeSrv, BusinessPartnerSet, AddressSet, ProductSet, PurchaseOrderSet, POItems } = cds.entities('CatalogService')

    this.before(['CREATE', 'UPDATE'], EmployeeSrv, async (req) => {
      var salary = parseFloat(req.data.salaryAmount);
      if (salary >= 1000000) {
        //inducing an error = exception hanlding
        req.error(500, "Wallah! the salary cannot be above 1mn")
      }

    })
    this.after('READ', EmployeeSrv, async (employeeSrv, req) => {
      console.log('After READ EmployeeSrv', employeeSrv)
    })
    this.before(['CREATE', 'UPDATE'], BusinessPartnerSet, async (req) => {
      console.log('Before CREATE/UPDATE BusinessPartnerSet', req.data)
    })
    this.after('READ', BusinessPartnerSet, async (businessPartnerSet, req) => {
      console.log('After READ BusinessPartnerSet', businessPartnerSet)
    })
    this.before(['CREATE', 'UPDATE'], AddressSet, async (req) => {
      console.log('Before CREATE/UPDATE AddressSet', req.data)
    })
    this.after('READ', AddressSet, async (addressSet, req) => {
      console.log('After READ AddressSet', addressSet)
    })
    this.before(['CREATE', 'UPDATE'], ProductSet, async (req) => {
      console.log('Before CREATE/UPDATE ProductSet', req.data)
    })
    this.after('READ', ProductSet, async (productSet, req) => {
      console.log('After READ ProductSet', productSet)
    })
    this.before(['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
      console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
    })
    // this.after('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {

    //   const ids = purchaseOrderSet.map(po => po.NODE_KEY);

    //   const partnerCount = await SELECT.from(PurchaseOrderSet)
    //     .columns('PARTNER_GUID', { func: 'count' })
    //     .where({ NODE_KEY: { in: ids } })
    //     .groupBy('PARTNER_GUID');

    //   for (let record of purchaseOrderSet) {
    //     const myData = partnerCount.find(partner => partner.PARTNER_GUID_NODE_KEY === record.PARTNER_GUID_NODE_KEY)
    //     record.PARTNER_COUNT = myData?.count || null;
    //     if(!record.NOTE){
    //       record.NOTE = '(No Value found)';
    //     }
    //   }

    // })
    this.before(['CREATE', 'UPDATE'], POItems, async (req) => {
      console.log('Before CREATE/UPDATE POItems', req.data)
    })
    this.after('READ', POItems, async (pOItems, req) => {
      console.log('After READ POItems', pOItems)
    })

    this.on('boost', async (req) => {
      const nodeKey = req.params[0];
      const tx = cds.tx(req);

      const updated = await tx.update(PurchaseOrderSet).with({
        GROSS_AMOUNT: { '+=': 20000 },
        NOTE: 'Boosted!!'
      }).where(nodeKey);

      const reply = await tx.read(PurchaseOrderSet).where(nodeKey);

      return reply;
    })

    this.on('getLargestPurcaseOrder', async (req) => {
      const tx = cds.tx(req);
      const resonse = await tx.read(PurchaseOrderSet)
        .orderBy({ 'GROSS_AMOUNT': 'desc' })
        .limit(1);
      return resonse;
    })
    this.on('getOrderStatus', async (req) => {
      return { OVERALL_STATUS: 'N' };
    })


    return super.init()
  }
}
