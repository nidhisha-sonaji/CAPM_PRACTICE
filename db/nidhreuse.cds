namespace nidh.reuse;
 
//reuse type for single field
type Guid : String(32);
 
 
//we want group of fields in our requirement
//like address data - houseNo, street, block, landmark, city, country
//structure are reusable
aspect address{
    houseNo: Integer;
    street: String(32);
    sector: String(44);
    landmark: String(80);
    city: String(55);
    country: String(4);
}