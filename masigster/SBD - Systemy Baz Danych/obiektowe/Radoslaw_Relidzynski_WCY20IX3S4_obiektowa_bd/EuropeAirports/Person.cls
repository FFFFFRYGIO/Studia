Class EuropeAirports.Person Extends %Persistent [ Abstract ]
{

Property FirstName As %String(MAXLEN = 20) [ Required ];

Property LastName As %String(MAXLEN = 20) [ Required ];

Property BirthDate As %DateTime [ Required ];

Property Gender As %String(MAXLEN = 1) [ Required ];

Method IsAdult() As %Boolean
{
    Set ageInDays = $ZDATETIMEH($HOROLOG, 3) - $ZDATETIMEH(..BirthDate, 3)

    If ageInDays >= (18 * 365) { Return 1 }
    Else { Return 0 }
}

Method GetDetails() As %String [ Abstract ]
{
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FirstName</Value>
</Value>
<Value name="3">
<Value>LastName</Value>
</Value>
<Value name="4">
<Value>BirthDate</Value>
</Value>
<Value name="5">
<Value>Gender</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^EuropeAirports.PersonD</IdLocation>
<IndexLocation>^EuropeAirports.PersonI</IndexLocation>
<StreamLocation>^EuropeAirports.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
