Class EuropeAirports.Ticket Extends (%Persistent, %XML.Adaptor)
{

Property TicketCode As %String(MAXLEN = 10) [ Required ];

Property Price As %Integer(MINVAL = 0) [ Required ];

Property SeatNumber As %Integer [ Required ];

Property FlightNumber As %Integer [ Required ];

Property AircraftNumber As %Integer [ Required ];

Property CustomerNumber As %Integer [ Required ];

Index TicketCodeIndex On TicketCode [ Unique ];

Relationship Customer As EuropeAirports.Customer [ Cardinality = one, Inverse = Tickets ];

Relationship Flight As EuropeAirports.Flight [ Cardinality = one, Inverse = Tickets ];

Relationship Seat As EuropeAirports.Seat [ Cardinality = many, Inverse = Ticket ];

Method ListTicketsForThisFlight() As %String
{
        Set ticketList = ""

        For i=1:1:..Flight.Tickets.Count()
        {
            Set ticket = ..Flight.Tickets.GetAt(i)
            Set ticketList = ticketList _ "TicketCode: " _ ticket.TicketCode _ $C(13,10)
        }

        Quit ticketList
}

Storage Default
{
<Data name="TicketDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TicketCode</Value>
</Value>
<Value name="3">
<Value>Price</Value>
</Value>
<Value name="4">
<Value>SeatNumber</Value>
</Value>
<Value name="5">
<Value>FlightNumber</Value>
</Value>
<Value name="6">
<Value>AircraftNumber</Value>
</Value>
<Value name="7">
<Value>CustomerNumber</Value>
</Value>
<Value name="8">
<Value>Customer</Value>
</Value>
<Value name="9">
<Value>Flight</Value>
</Value>
<Value name="10">
<Value>Seat</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.TicketD</DataLocation>
<DefaultData>TicketDefaultData</DefaultData>
<IdLocation>^EuropeAirports.TicketD</IdLocation>
<IndexLocation>^EuropeAirports.TicketI</IndexLocation>
<StreamLocation>^EuropeAirports.TicketS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
