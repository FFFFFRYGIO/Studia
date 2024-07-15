Class EuropeAirports.Aircraft Extends (%Persistent, %XML.Adaptor)
{

Property AircraftNumber As %Integer [ Identity, Required ];

Property ProductionYear As %Integer [ Required ];

Property ModelNumber As %Integer [ Required ];

Index AircraftNumberIndex On AircraftNumber [ Unique ];

Relationship Model As EuropeAirports.Model [ Cardinality = one, Inverse = Aircrafts ];

Relationship Flights As EuropeAirports.Flight [ Cardinality = many, Inverse = Aircraft ];

Relationship Seats As EuropeAirports.Seat [ Cardinality = many, Inverse = Aircraft ];

Method GetDetails() As %String
{
    Quit "AircraftNumber: " _ ..AircraftNumber _ $C(13,10) _ "ProductionYear: " _ ..ProductionYear _ $C(13,10) _ "ModelNumber: " _ ..ModelNumber
}

Storage Default
{
<Data name="AircraftDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ProductionYear</Value>
</Value>
<Value name="3">
<Value>ModelNumber</Value>
</Value>
<Value name="4">
<Value>Model</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.AircraftD</DataLocation>
<DefaultData>AircraftDefaultData</DefaultData>
<IdLocation>^EuropeAirports.AircraftD</IdLocation>
<IndexLocation>^EuropeAirports.AircraftI</IndexLocation>
<StreamLocation>^EuropeAirports.AircraftS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
