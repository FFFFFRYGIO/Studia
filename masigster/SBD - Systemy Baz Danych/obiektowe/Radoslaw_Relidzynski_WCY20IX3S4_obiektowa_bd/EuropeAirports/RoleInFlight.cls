Class EuropeAirports.RoleInFlight Extends (%Persistent, %XML.Adaptor)
{

Property EmployeeNumber As %Integer [ Required ];

Property FlightNumber As %Integer [ Required ];

Property JobRole As EuropeAirports.JobRole [ Required ];

Index RoleIndex On (EmployeeNumber, FlightNumber) [ Unique ];

Relationship Employee As EuropeAirports.Employee [ Cardinality = one, Inverse = Roles ];

Relationship Flight As EuropeAirports.Flight [ Cardinality = one, Inverse = Roles ];

Storage Default
{
<Data name="RoleInFlightDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EmployeeNumber</Value>
</Value>
<Value name="3">
<Value>FlightNumber</Value>
</Value>
<Value name="4">
<Value>JobRole</Value>
</Value>
<Value name="5">
<Value>Employee</Value>
</Value>
<Value name="6">
<Value>Flight</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.RoleInFlightD</DataLocation>
<DefaultData>RoleInFlightDefaultData</DefaultData>
<IdLocation>^EuropeAirports.RoleInFlightD</IdLocation>
<IndexLocation>^EuropeAirports.RoleInFlightI</IndexLocation>
<StreamLocation>^EuropeAirports.RoleInFlightS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
