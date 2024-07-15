Class EuropeAirports.Customer Extends EuropeAirports.Person
{

Property CustomerNumber As %Integer [ Required ];

Index CustomerNumberIndex On CustomerNumber [ Unique ];

Property DiscountType As %String(MAXLEN = 20);

Relationship Tickets As EuropeAirports.Ticket [ Cardinality = many, Inverse = Customer ];

Relationship Discount As EuropeAirports.Discount [ Cardinality = one, Inverse = Customers ];

Method GetDetails() As %String
{
    Quit ..CustomerNumber _ " " _ ..FirstName _ " " _ ..LastName _ " " _ ..Discount
}

Method BookAFlight(SeatNumber As %Integer, FlightNumber As %Integer, Price As %Integer, TicketCode As %String) As %Status
{
    Set NewTicket = ##class(EuropeAirports.Ticket).%New()
    Set NewTicket.SeatNumber = SeatNumber
    Set NewTicket.FlightNumber = FlightNumber
    Set NewTicket.Price = Price
    Set NewTicket.CustomerNumber = ..CustomerNumber
    Set NewTicket.TicketCode = TicketCode

    Set Flight = ##class(EuropeAirports.Flight).%OpenId(FlightNumber)
    If Flight = $$$NULLOREF {
        Return $$$ERROR($$$GeneralError, "Invalid FlightNumber")
    }
    Set NewTicket.AircraftNumber = Flight.AircraftNumber

    Set sc = NewTicket.%Save()
    If $$$ISERR(sc) {
        Return sc
    }

    Set sc = ..Tickets.Relate(NewTicket)
    If $$$ISERR(sc) {
        Return sc
    }

    Return $$$OK
}

Storage Default
{
<Data name="CustomerDefaultData">
<Subscript>"Customer"</Subscript>
<Value name="1">
<Value>CustomerNumber</Value>
</Value>
<Value name="2">
<Value>DiscountType</Value>
</Value>
<Value name="3">
<Value>Discount</Value>
</Value>
</Data>
<DefaultData>CustomerDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
