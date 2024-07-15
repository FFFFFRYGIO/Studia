Class EuropeAirports.Model Extends (%Persistent, %XML.Adaptor)
{

Property ModelNumber As %Integer [ Identity, Required ];

Property Name As %String(MAXLEN = 40) [ Required ];

Index ModelNumberIndex On ModelNumber [ Unique ];

Relationship Aircrafts As EuropeAirports.Aircraft [ Cardinality = many, Inverse = Model ];

Relationship Licenses As EuropeAirports.License [ Cardinality = many, Inverse = Model ];

Storage Default
{
<Data name="ModelDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^EuropeAirports.ModelD</DataLocation>
<DefaultData>ModelDefaultData</DefaultData>
<IdLocation>^EuropeAirports.ModelD</IdLocation>
<IndexLocation>^EuropeAirports.ModelI</IndexLocation>
<StreamLocation>^EuropeAirports.ModelS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
