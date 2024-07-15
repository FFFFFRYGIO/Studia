Class EuropeAirports.Seat Extends (%Persistent, %XML.Adaptor)
{

Property SeatNumber As %Integer [ Required ];

Property Class As %String(MAXLEN = 20) [ Required ];

Property AircraftNumber As %Integer [ Required ];

Index SeatIndex On (SeatNumber, AircraftNumber) [ Unique ];

Relationship Aircraft As EuropeAirports.Aircraft [ Cardinality = one, Inverse = Seats ];

Relationship Ticket As EuropeAirports.Ticket [ Cardinality = one, Inverse = Seat ];

Index TicketAIndex On Ticket [ Unique ];

Storage Default
{
<Data name="SeatDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SeatNumber</Value>
</Value>
<Value name="3">
<Value>Class</Value>
</Value>
<Value name="4">
<Value>AircraftNumber</Value>
</Value>
<Value name="5">
<Value>Aircraft</Value>
</Value>
<Value name="6">
<Value>Tickets</Value>
</Value>
<Value name="7">
<Value>Ticket</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.SeatD</DataLocation>
<DefaultData>SeatDefaultData</DefaultData>
<IdLocation>^EuropeAirports.SeatD</IdLocation>
<IndexLocation>^EuropeAirports.SeatI</IndexLocation>
<StreamLocation>^EuropeAirports.SeatS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
