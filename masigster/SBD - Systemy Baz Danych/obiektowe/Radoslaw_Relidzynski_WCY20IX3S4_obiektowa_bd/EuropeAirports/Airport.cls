Class EuropeAirports.Airport Extends (%Persistent, %XML.Adaptor)
{

Property AirportNumber As %Integer [ Identity, Required ];

Property Name As %String(MAXLEN = 40) [ Required ];

Property Country As %String(MAXLEN = 20) [ Required ];

Index AirportNumberIndex On AirportNumber [ Unique ];

Relationship FlightsFrom As EuropeAirports.Flight [ Cardinality = many, Inverse = StartAirportObj ];

Relationship FlightsTo As EuropeAirports.Flight [ Cardinality = many, Inverse = DestinationAirportObj ];

Storage Default
{
<Data name="AirportDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Country</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.AirportD</DataLocation>
<DefaultData>AirportDefaultData</DefaultData>
<IdLocation>^EuropeAirports.AirportD</IdLocation>
<IndexLocation>^EuropeAirports.AirportI</IndexLocation>
<StreamLocation>^EuropeAirports.AirportS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
