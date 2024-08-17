module.exports= cds.service.impl(async function(){
    const { EmployeeSet, POs } = this.entities;


    this.before('UPDATE',EmployeeSet,(req)=>{
        var sal = req.data.salaryAmount;
        if( sal >= 90000){
            req.error("Oops! High salary not allowed here")
        }
    });

    this.after('READ',EmployeeSet,(data)=>{
        data.push({
            "ID":"CUSTOM",
            "nameFirst":"DummyName"

        });
        
    });

    this.on('boost',async (req,res)=>{
        try {
            //since its instance bound we will get the key of PO
            const boostid = req.params[0];
            //Print on console the key
            console.log("Hey Amigo, Your purchase order with id " + req.params[0] + " will be boosted");
            //Start a db transaction suing cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
            const tx = cds.tx(req);
            //UPDATE dbtab set grossamount = current + 20k WHERE ID = key
            await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where(boostid);
        } catch (error) {
            return "Error " + error.toString();
        }
    
    });

    this.on('getLargestOrder',async(req,res)=>{
        try{
            const id = req.params[0];
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                GROSS_AMOUNT : 'desc'
            }).limit(1);
            return reply;
            // //const id = req.params[0];
            // //const tx = cds.tx(req);
            // const reply = await srv.run(select.from(POs).orderBy({
            //     GROSS_AMOUNT : 'desc'
            // }).limit(1));
            // return reply;
        }
        catch(error){
            return "Error" + error.toString();
        }
    });

    this.on('getStatusDefault',async(req,res)=>{
        return {
            "OVERALL_STATUS":"N"
            
        };
        
    })



}) 
