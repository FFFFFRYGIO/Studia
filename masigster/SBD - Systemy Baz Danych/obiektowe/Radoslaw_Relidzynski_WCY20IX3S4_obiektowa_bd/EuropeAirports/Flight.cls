Class EuropeAirports.Flight Extends (%Persistent, %XML.Adaptor)
{

Property FlightNumber As %Integer [ Identity, Required ];

Property FlightDate As %DateTime [ Required ];

Property FlightDurationMinutes As %Integer(MINVAL = 1) [ Required ];

Property StartAirport As %Integer [ Required ];

Property DestinationAirport As %Integer [ Required ];

Property AircraftNumber As %Integer [ Required ];

Index FlightNumberIndex On FlightNumber [ Unique ];

Relationship StartAirportObj As EuropeAirports.Airport [ Cardinality = one, Inverse = FlightsFrom ];

Relationship DestinationAirportObj As EuropeAirports.Airport [ Cardinality = one, Inverse = FlightsTo ];

Relationship Tickets As EuropeAirports.Ticket [ Cardinality = many, Inverse = Flight ];

Relationship Aircraft As EuropeAirports.Aircraft [ Cardinality = one, Inverse = Flights ];

Relationship Roles As EuropeAirports.RoleInFlight [ Cardinality = many, Inverse = Flight ];

Method calculateIncome() As %Integer
{
    Set total = 0

    For i=1:1:..Tickets.Count()
    {
        Set total = total + ..Tickets.GetAt(i).Price
    }

    Return total
}

Storage Default
{
<Data name="FlightDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FlightDate</Value>
</Value>
<Value name="3">
<Value>FlightDurationMinutes</Value>
</Value>
<Value name="4">
<Value>StartAirport</Value>
</Value>
<Value name="5">
<Value>DestinationAirport</Value>
</Value>
<Value name="6">
<Value>AircraftNumber</Value>
</Value>
<Value name="7">
<Value>StartAirportObj</Value>
</Value>
<Value name="8">
<Value>DestinationAirportObj</Value>
</Value>
<Value name="9">
<Value>Aircraft</Value>
</Value>
<Value name="10">
<Value>Roles</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.FlightD</DataLocation>
<DefaultData>FlightDefaultData</DefaultData>
<IdLocation>^EuropeAirports.FlightD</IdLocation>
<IndexLocation>^EuropeAirports.FlightI</IndexLocation>
<StreamLocation>^EuropeAirports.FlightS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
