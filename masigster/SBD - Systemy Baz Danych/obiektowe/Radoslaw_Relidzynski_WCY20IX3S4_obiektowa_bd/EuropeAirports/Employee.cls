Class EuropeAirports.Employee Extends EuropeAirports.Person
{

Property EmployeeNumber As %Integer [ Required ];

Index EmployeeNumberIndex On EmployeeNumber [ Unique ];

Relationship Licenses As EuropeAirports.License [ Cardinality = many, Inverse = Employee ];

Relationship Roles As EuropeAirports.RoleInFlight [ Cardinality = many, Inverse = Employee ];

Method GetDetails() As %String
{
    Quit ..EmployeeNumber _ " " _ ..FirstName _ " " _ ..LastName
}

Storage Default
{
<Data name="EmployeeDefaultData">
<Subscript>"Employee"</Subscript>
<Value name="1">
<Value>EmployeeNumber</Value>
</Value>
</Data>
<DefaultData>EmployeeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
