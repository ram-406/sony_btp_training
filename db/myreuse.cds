namespace sony.metro.reuse;

type Guid: String(32) @title : 'Key';

aspect address{
    houseNo: Int64;
    landmark: String(255);
    city: String(64);
    country: String(2);
    region: String(4);
}
