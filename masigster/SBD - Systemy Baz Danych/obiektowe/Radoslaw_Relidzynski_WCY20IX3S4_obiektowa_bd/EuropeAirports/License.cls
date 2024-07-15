Class EuropeAirports.License Extends (%Persistent, %XML.Adaptor)
{

Property EmployeeNumber As %Integer [ Required ];

Property ModelNumber As %Integer [ Required ];

Index LicenseIndex On (EmployeeNumber, ModelNumber) [ Unique ];

Relationship Employee As EuropeAirports.Employee [ Cardinality = one, Inverse = Licenses ];

Relationship Model As EuropeAirports.Model [ Cardinality = one, Inverse = Licenses ];

Storage Default
{
<Data name="LicenseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EmployeeNumber</Value>
</Value>
<Value name="3">
<Value>ModelNumber</Value>
</Value>
<Value name="4">
<Value>Employee</Value>
</Value>
<Value name="5">
<Value>Model</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.LicenseD</DataLocation>
<DefaultData>LicenseDefaultData</DefaultData>
<IdLocation>^EuropeAirports.LicenseD</IdLocation>
<IndexLocation>^EuropeAirports.LicenseI</IndexLocation>
<StreamLocation>^EuropeAirports.LicenseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
