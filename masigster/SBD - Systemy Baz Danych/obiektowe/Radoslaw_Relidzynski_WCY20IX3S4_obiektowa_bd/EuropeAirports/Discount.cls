Class EuropeAirports.Discount Extends (%Persistent, %XML.Adaptor)
{

Property DiscountType As %String(MAXLEN = 20) [ Required ];

Property DiscountPercentage As %Integer(MAXVAL = 100, MINVAL = 0) [ Required ];

Index DiscountTypeIndex On DiscountType [ Unique ];

Relationship Customers As EuropeAirports.Customer [ Cardinality = many, Inverse = Discount ];

Method UpdateDiscountPercentage(NewPercentage As %Integer) As %Status
{
    If (NewPercentage < 0) || (NewPercentage > 100) {
        Return $$$ERROR($$$GeneralError, "New discount percentage must be between 0 and 100")
    }

    Set ..DiscountPercentage = NewPercentage
    Return ..%Save()
}

Storage Default
{
<Data name="DiscountDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DiscountType</Value>
</Value>
<Value name="3">
<Value>DiscountPercentage</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.DiscountD</DataLocation>
<DefaultData>DiscountDefaultData</DefaultData>
<IdLocation>^EuropeAirports.DiscountD</IdLocation>
<IndexLocation>^EuropeAirports.DiscountI</IndexLocation>
<StreamLocation>^EuropeAirports.DiscountS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
