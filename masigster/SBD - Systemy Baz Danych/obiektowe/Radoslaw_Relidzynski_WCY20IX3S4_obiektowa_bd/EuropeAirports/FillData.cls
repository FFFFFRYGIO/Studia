Class EuropeAirports.FillData Extends %RegisteredObject
{

ClassMethod ClearData() As %Status
{
    Set sc = $$$OK
    Try {
        Do ##class(EuropeAirports.RoleInFlight).%KillExtent()
        Do ##class(EuropeAirports.License).%KillExtent()
        Do ##class(EuropeAirports.Ticket).%KillExtent()
        Do ##class(EuropeAirports.Seat).%KillExtent()
        Do ##class(EuropeAirports.Flight).%KillExtent()
        Do ##class(EuropeAirports.Employee).%KillExtent()
        Do ##class(EuropeAirports.Customer).%KillExtent()
        Do ##class(EuropeAirports.Aircraft).%KillExtent()
        Do ##class(EuropeAirports.Model).%KillExtent()
        Do ##class(EuropeAirports.Airport).%KillExtent()
        Do ##class(EuropeAirports.Discount).%KillExtent()
        Write "Cleared all data",!
    } Catch ex {
        Write "Error ClearData: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillDiscounts() As %Status
{
    Set sc = $$$OK
    Try {
        Set DiscountsArray = ##class(%DynamicArray).%New()

        Do DiscountsArray.%Push({"DiscountType": "rodzinna", "DiscountPercentage": 37})
        Do DiscountsArray.%Push({"DiscountType": "student", "DiscountPercentage": 50})
        Do DiscountsArray.%Push({"DiscountType": "krwiodawca", "DiscountPercentage": 75})

        For i=0:1:DiscountsArray.%Size() -1 {
            Set DiscountDetails = DiscountsArray.%Get(i)
            Set NewDiscount = ##class(EuropeAirports.Discount).%New()
            Set NewDiscount.DiscountType = DiscountDetails.%Get("DiscountType")
            Set NewDiscount.DiscountPercentage = DiscountDetails.%Get("DiscountPercentage")
            Set sc = NewDiscount.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewDiscount: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Discounts filled with data",!
    } Catch ex {
        Write "Error FillDiscounts: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillCustomers() As %Status
{
    Set sc = $$$OK
    Try {
        Set CustomersArray = ##class(%DynamicArray).%New()

        Do CustomersArray.%Push({"FirstName": "Kamil", "LastName": "Madajski", "BirthDate": "2000-12-01", "DiscountType": "student", "Gender": "M"})
        Do CustomersArray.%Push({"FirstName": "Emilia", "LastName": "Książkiewicz", "BirthDate": "1990-02-06", "DiscountType": "rodzinna", "Gender": "K"})
        Do CustomersArray.%Push({"FirstName": "Mateusz", "LastName": "Dybek", "BirthDate": "1993-06-12", "DiscountType": "", "Gender": "M"})
        Do CustomersArray.%Push({"FirstName": "Zofia", "LastName": "Komosa", "BirthDate": "2001-05-12", "DiscountType": "student", "Gender": "K"})
        Do CustomersArray.%Push({"FirstName": "Krystyna", "LastName": "Czarniak", "BirthDate": "1992-12-05", "DiscountType": "", "Gender": "K"})
        Do CustomersArray.%Push({"FirstName": "Janusz", "LastName": "Grzelczak", "BirthDate": "2002-08-03", "DiscountType": "student", "Gender": "M"})
        Do CustomersArray.%Push({"FirstName": "Albert", "LastName": "Świątkowski", "BirthDate": "1995-04-06", "DiscountType": "krwiodawca", "Gender": "M"})
        Do CustomersArray.%Push({"FirstName": "Krzysztof", "LastName": "Cieluch", "BirthDate": "1991-10-09", "DiscountType": "rodzinna", "Gender": "M"})
        Do CustomersArray.%Push({"FirstName": "Małgorzata", "LastName": "Handzlik", "BirthDate": "2001-08-11", "DiscountType": "", "Gender": "K"})
        Do CustomersArray.%Push({"FirstName": "Tobiasz", "LastName": "Ciszek", "BirthDate": "1996-08-03", "DiscountType": "rodzinna", "Gender": "M"})

        For i=0:1:CustomersArray.%Size() -1 {
            Set CustomerDetails = CustomersArray.%Get(i)
            Set NewCustomer = ##class(EuropeAirports.Customer).%New()
            Set NewCustomer.CustomerNumber = i + 1
            Set NewCustomer.FirstName = CustomerDetails.%Get("FirstName")
            Set NewCustomer.LastName = CustomerDetails.%Get("LastName")
            Set NewCustomer.BirthDate = CustomerDetails.%Get("BirthDate")
            Set NewCustomer.DiscountType = CustomerDetails.%Get("DiscountType")
            Set NewCustomer.Gender = CustomerDetails.%Get("Gender")

            Set sc = NewCustomer.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewCustomer: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Customers filled with data",!
    } Catch ex {
        Write "Error FillCustomers: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillAirports() As %Status
{
    Set sc = $$$OK
    Try {
        Set AirportsArray = ##class(%DynamicArray).%New()

        Do AirportsArray.%Push({"Name": "Londyn Heathrow", "Country": "Anglia"})
        Do AirportsArray.%Push({"Name": "Paryż Charles de Gaulle", "Country": "Francja"})
        Do AirportsArray.%Push({"Name": "Frankfurt International Airport", "Country": "Niemcy"})
        Do AirportsArray.%Push({"Name": "Amsterdam Airport", "Country": "Holandia"})
        Do AirportsArray.%Push({"Name": "Rzym Fiumicino", "Country": "Włochy"})
        Do AirportsArray.%Push({"Name": "Madryt", "Country": "Hiszpania"})
        Do AirportsArray.%Push({"Name": "Monachium", "Country": "Niemcy"})
        Do AirportsArray.%Push({"Name": "Barcelona Airport", "Country": "Hiszpania"})

        For i=0:1:AirportsArray.%Size() -1 {
            Set AirportDetails = AirportsArray.%Get(i)
            Set NewAirport = ##class(EuropeAirports.Airport).%New()
            Set NewAirport.Name = AirportDetails.%Get("Name")
            Set NewAirport.Country = AirportDetails.%Get("Country")

            Set sc = NewAirport.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewAirport: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Airports filled with data",!
    } Catch ex {
        Write "Error FillAirports: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillModels() As %Status
{
    Set sc = $$$OK
    Try {
        Set ModelsArray = ##class(%DynamicArray).%New()

        Do ModelsArray.%Push({"Name": "Boeing 787-8 Dreamliner"})
        Do ModelsArray.%Push({"Name": "Boeing 747-200"})
        Do ModelsArray.%Push({"Name": "DHC-6 Twin Otter"})
        Do ModelsArray.%Push({"Name": "Antonov AN-225 Mrija"})
        Do ModelsArray.%Push({"Name": "Boeing 777-300ER"})
        Do ModelsArray.%Push({"Name": "DC-4 Balair"})
        Do ModelsArray.%Push({"Name": "A380-800 British Airways"})
        Do ModelsArray.%Push({"Name": "Concorde"})
        Do ModelsArray.%Push({"Name": "Boeing 747-300"})
        Do ModelsArray.%Push({"Name": "C-54D Skymaster"})

        For i=0:1:ModelsArray.%Size() -1 {
            Set ModelDetails = ModelsArray.%Get(i)
            Set NewModel = ##class(EuropeAirports.Model).%New()
            Set NewModel.Name = ModelDetails.%Get("Name")

            Set sc = NewModel.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewModel: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Models filled with data",!
    } Catch ex {
        Write "Error FillModels: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillEmployees() As %Status
{
    Set sc = $$$OK
    Try {
        Set EmployeesArray = ##class(%DynamicArray).%New()

        Do EmployeesArray.%Push({"FirstName": "Mariusz", "LastName": "Szuszkiewicz", "BirthDate": "1985-07-01", "Gender": "M"})
        Do EmployeesArray.%Push({"FirstName": "Piotr", "LastName": "Gała", "BirthDate": "1981-01-25", "Gender": "M"})
        Do EmployeesArray.%Push({"FirstName": "Waldemar", "LastName": "Świerczewski", "BirthDate": "1992-11-14", "Gender": "M"})
        Do EmployeesArray.%Push({"FirstName": "Maja", "LastName": "Kozik", "BirthDate": "1990-11-15", "Gender": "K"})
        Do EmployeesArray.%Push({"FirstName": "Joanna", "LastName": "Krupa", "BirthDate": "1991-07-13", "Gender": "K"})
        Do EmployeesArray.%Push({"FirstName": "Natalia", "LastName": "Kortas", "BirthDate": "1983-03-05", "Gender": "K"})
        Do EmployeesArray.%Push({"FirstName": "Tomasz", "LastName": "Klasa", "BirthDate": "1981-06-09", "Gender": "M"})
        Do EmployeesArray.%Push({"FirstName": "Szymon", "LastName": "Bucior", "BirthDate": "1989-01-02", "Gender": "M"})
        Do EmployeesArray.%Push({"FirstName": "Emil", "LastName": "Mieczkowski", "BirthDate": "1982-07-21", "Gender": "M"})
        Do EmployeesArray.%Push({"FirstName": "Maria", "LastName": "Wieczorek", "BirthDate": "1990-05-22", "Gender": "K"})

        For i=0:1:EmployeesArray.%Size() -1 {
            Set EmployeeDetails = EmployeesArray.%Get(i)
            Set NewEmployee = ##class(EuropeAirports.Employee).%New()
            Set NewEmployee.EmployeeNumber = i + 1
            Set NewEmployee.FirstName = EmployeeDetails.%Get("FirstName")
            Set NewEmployee.LastName = EmployeeDetails.%Get("LastName")
            Set NewEmployee.BirthDate = EmployeeDetails.%Get("BirthDate")
            Set NewEmployee.Gender = EmployeeDetails.%Get("Gender")

            Set sc = NewEmployee.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewEmployee: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Employees filled with data",!
    } Catch ex {
        Write "Error FillEmployees: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillLicenses() As %Status
{
    Set sc = $$$OK
    Try {
        Set LicensesArray = ##class(%DynamicArray).%New()

        Do LicensesArray.%Push({"EmployeeNumber": 1, "ModelNumber": 3})
        Do LicensesArray.%Push({"EmployeeNumber": 1, "ModelNumber": 1})
        Do LicensesArray.%Push({"EmployeeNumber": 1, "ModelNumber": 4})
        Do LicensesArray.%Push({"EmployeeNumber": 2, "ModelNumber": 10})
        Do LicensesArray.%Push({"EmployeeNumber": 2, "ModelNumber": 1})
        Do LicensesArray.%Push({"EmployeeNumber": 2, "ModelNumber": 8})
        Do LicensesArray.%Push({"EmployeeNumber": 3, "ModelNumber": 7})
        Do LicensesArray.%Push({"EmployeeNumber": 3, "ModelNumber": 8})
        Do LicensesArray.%Push({"EmployeeNumber": 3, "ModelNumber": 3})
        Do LicensesArray.%Push({"EmployeeNumber": 4, "ModelNumber": 2})
        Do LicensesArray.%Push({"EmployeeNumber": 4, "ModelNumber": 8})
        Do LicensesArray.%Push({"EmployeeNumber": 4, "ModelNumber": 4})

        For i=0:1:LicensesArray.%Size() -1 {
            Set LicenseDetails = LicensesArray.%Get(i)
            Set NewLicense = ##class(EuropeAirports.License).%New()
            Set NewLicense.EmployeeNumber = LicenseDetails.%Get("EmployeeNumber")
            Set NewLicense.ModelNumber = LicenseDetails.%Get("ModelNumber")

            Set sc = NewLicense.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewLicense: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Licenses filled with data",!
    } Catch ex {
        Write "Error FillLicenses: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillAircrafts() As %Status
{
    Set sc = $$$OK
    Try {
        Set AircraftsArray = ##class(%DynamicArray).%New()

        Do AircraftsArray.%Push({"ProductionYear": 2013, "ModelNumber": 8})
        Do AircraftsArray.%Push({"ProductionYear": 2015, "ModelNumber": 2})
        Do AircraftsArray.%Push({"ProductionYear": 2010, "ModelNumber": 7})
        Do AircraftsArray.%Push({"ProductionYear": 2005, "ModelNumber": 4})
        Do AircraftsArray.%Push({"ProductionYear": 2008, "ModelNumber": 5})
        Do AircraftsArray.%Push({"ProductionYear": 2014, "ModelNumber": 1})
        Do AircraftsArray.%Push({"ProductionYear": 2019, "ModelNumber": 7})
        Do AircraftsArray.%Push({"ProductionYear": 2010, "ModelNumber": 10})
        Do AircraftsArray.%Push({"ProductionYear": 2013, "ModelNumber": 8})
        Do AircraftsArray.%Push({"ProductionYear": 2010, "ModelNumber": 1})

        For i=0:1:AircraftsArray.%Size() -1 {
            Set AircraftDetails = AircraftsArray.%Get(i)
            Set NewAircraft = ##class(EuropeAirports.Aircraft).%New()
            Set NewAircraft.ProductionYear = AircraftDetails.%Get("ProductionYear")
            Set NewAircraft.ModelNumber = AircraftDetails.%Get("ModelNumber")

            Set sc = NewAircraft.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewAircraft: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Aircrafts filled with data",!
    } Catch ex {
        Write "Error FillAircrafts: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillFlights() As %Status
{
    Set sc = $$$OK
    Try {
        Set FlightsArray = ##class(%DynamicArray).%New()

        Do FlightsArray.%Push({"FlightDate": "2025-04-16", "FlightDurationMinutes": 240, "AircraftNumber": 3, "StartAirport": 5, "DestinationAirport": 1})
        Do FlightsArray.%Push({"FlightDate": "2025-06-23", "FlightDurationMinutes": 270, "AircraftNumber": 2, "StartAirport": 8, "DestinationAirport": 3})
        Do FlightsArray.%Push({"FlightDate": "2025-01-13", "FlightDurationMinutes": 240, "AircraftNumber": 10, "StartAirport": 7, "DestinationAirport": 2})
        Do FlightsArray.%Push({"FlightDate": "2025-05-31", "FlightDurationMinutes": 120, "AircraftNumber": 1, "StartAirport": 6, "DestinationAirport": 3})
        Do FlightsArray.%Push({"FlightDate": "2025-01-01", "FlightDurationMinutes": 150, "AircraftNumber": 8, "StartAirport": 7, "DestinationAirport": 5})
        Do FlightsArray.%Push({"FlightDate": "2025-09-26", "FlightDurationMinutes": 240, "AircraftNumber": 7, "StartAirport": 1, "DestinationAirport": 5})
        Do FlightsArray.%Push({"FlightDate": "2025-09-23", "FlightDurationMinutes": 60, "AircraftNumber": 3, "StartAirport": 3, "DestinationAirport": 4})
        Do FlightsArray.%Push({"FlightDate": "2025-03-29", "FlightDurationMinutes": 90, "AircraftNumber": 4, "StartAirport": 6, "DestinationAirport": 3})
        Do FlightsArray.%Push({"FlightDate": "2025-07-23", "FlightDurationMinutes": 60, "AircraftNumber": 2, "StartAirport": 8, "DestinationAirport": 7})
        Do FlightsArray.%Push({"FlightDate": "2025-03-19", "FlightDurationMinutes": 90, "AircraftNumber": 4, "StartAirport": 2, "DestinationAirport": 3})

        For i=0:1:FlightsArray.%Size() -1 {
            Set FlightDetails = FlightsArray.%Get(i)
            Set NewFlight = ##class(EuropeAirports.Flight).%New()
            // Set NewFlight.FlightNumber = i + 1
            Set NewFlight.FlightDate = FlightDetails.%Get("FlightDate")
            Set NewFlight.FlightDurationMinutes = FlightDetails.%Get("FlightDurationMinutes")
            Set NewFlight.StartAirport = FlightDetails.%Get("StartAirport")
            Set NewFlight.DestinationAirport = FlightDetails.%Get("DestinationAirport")
            Set NewFlight.AircraftNumber = FlightDetails.%Get("AircraftNumber")

            Set sc = NewFlight.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewFlight: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Flights filled with data",!
    } Catch ex {
        Write "Error FillFlights: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillRolesInFlight() As %Status
{
    Set sc = $$$OK
    Try {
        Set RolesInFlightArray = ##class(%DynamicArray).%New()

        Do RolesInFlightArray.%Push({"FlightNumber": 1, "EmployeeNumber": 3, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 1, "EmployeeNumber": 5, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 1, "EmployeeNumber": 9, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 2, "EmployeeNumber": 4, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 2, "EmployeeNumber": 6, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 2, "EmployeeNumber": 8, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 3, "EmployeeNumber": 2, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 3, "EmployeeNumber": 8, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 3, "EmployeeNumber": 9, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 4, "EmployeeNumber": 2, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 4, "EmployeeNumber": 6, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 4, "EmployeeNumber": 9, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 5, "EmployeeNumber": 2, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 5, "EmployeeNumber": 7, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 5, "EmployeeNumber": 9, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 6, "EmployeeNumber": 3, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 6, "EmployeeNumber": 7, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 6, "EmployeeNumber": 10, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 7, "EmployeeNumber": 3, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 7, "EmployeeNumber": 7, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 7, "EmployeeNumber": 10, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 8, "EmployeeNumber": 1, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 8, "EmployeeNumber": 6, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 8, "EmployeeNumber": 9, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 9, "EmployeeNumber": 4, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 9, "EmployeeNumber": 5, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 9, "EmployeeNumber": 9, "JobRole": "mechanik"})
        Do RolesInFlightArray.%Push({"FlightNumber": 10, "EmployeeNumber": 1, "JobRole": "pilot"})
        Do RolesInFlightArray.%Push({"FlightNumber": 10, "EmployeeNumber": 8, "JobRole": "steward"})
        Do RolesInFlightArray.%Push({"FlightNumber": 10, "EmployeeNumber": 10, "JobRole": "mechanik"})

        For i=0:1:RolesInFlightArray.%Size() -1 {
            Set RoleDetails = RolesInFlightArray.%Get(i)
            Set NewRole = ##class(EuropeAirports.RoleInFlight).%New()
            Set NewRole.EmployeeNumber = RoleDetails.%Get("EmployeeNumber")
            Set NewRole.FlightNumber = RoleDetails.%Get("FlightNumber")
            Set NewRole.JobRole = RoleDetails.%Get("JobRole")

            Set sc = NewRole.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewRole: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "RolesInFlight filled with data",!
    } Catch ex {
        Write "Error FillRolesInFlight: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillSeats() As %Status
{
    Set sc = $$$OK
    Try {
        Set SeatsArray = ##class(%DynamicArray).%New()

        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 1})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 1})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 1})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 1})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 1})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 2})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 2})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 2})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 2})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 2})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 3})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 3})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 3})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 3})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 3})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 4})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 4})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 4})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 4})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 4})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 5})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 5})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 5})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 5})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 5})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 6})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 6})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 6})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 6})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 6})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 7})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 7})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 7})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 7})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 7})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 8})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 8})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 8})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 8})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 8})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 9})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 9})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 9})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 9})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 9})
        Do SeatsArray.%Push({"SeatNumber": 1, "Class": "biznes", "AircraftNumber": 10})
        Do SeatsArray.%Push({"SeatNumber": 2, "Class": "pierwsza", "AircraftNumber": 10})
        Do SeatsArray.%Push({"SeatNumber": 3, "Class": "pierwsza", "AircraftNumber": 10})
        Do SeatsArray.%Push({"SeatNumber": 4, "Class": "ekonomiczna", "AircraftNumber": 10})
        Do SeatsArray.%Push({"SeatNumber": 5, "Class": "ekonomiczna", "AircraftNumber": 10})

        For i=0:1:SeatsArray.%Size() -1 {
            Set SeatDetails = SeatsArray.%Get(i)
            Set NewSeat = ##class(EuropeAirports.Seat).%New()
            Set NewSeat.SeatNumber = SeatDetails.%Get("SeatNumber")
            Set NewSeat.Class = SeatDetails.%Get("Class")
            Set NewSeat.AircraftNumber = SeatDetails.%Get("AircraftNumber")

            Set sc = NewSeat.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewSeat: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Seats filled with data",!
    } Catch ex {
        Write "Error FillSeats: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillTickets() As %Status
{
    Set sc = $$$OK
    Try {
        Set TicketsArray = ##class(%DynamicArray).%New()

        Do TicketsArray.%Push({"TicketCode": "NZY114", "FlightNumber": 1, "AircraftNumber": 3, "SeatNumber": 1, "CustomerNumber": 4, "Price": 141.78})
        Do TicketsArray.%Push({"TicketCode": "RND132", "FlightNumber": 1, "AircraftNumber": 3, "SeatNumber": 2, "CustomerNumber": 2, "Price": 92.16})
        Do TicketsArray.%Push({"TicketCode": "YMD153", "FlightNumber": 1, "AircraftNumber": 3, "SeatNumber": 4, "CustomerNumber": 3, "Price": 70.89})
        Do TicketsArray.%Push({"TicketCode": "NIE210", "FlightNumber": 2, "AircraftNumber": 2, "SeatNumber": 1, "CustomerNumber": 10, "Price": 139.0})
        Do TicketsArray.%Push({"TicketCode": "BIM239", "FlightNumber": 2, "AircraftNumber": 2, "SeatNumber": 3, "CustomerNumber": 9, "Price": 90.35})
        Do TicketsArray.%Push({"TicketCode": "YVY257", "FlightNumber": 2, "AircraftNumber": 2, "SeatNumber": 5, "CustomerNumber": 7, "Price": 69.5})
        Do TicketsArray.%Push({"TicketCode": "QZS315", "FlightNumber": 3, "AircraftNumber": 10, "SeatNumber": 1, "CustomerNumber": 5, "Price": 144.36})
        Do TicketsArray.%Push({"TicketCode": "HHC332", "FlightNumber": 3, "AircraftNumber": 10, "SeatNumber": 3, "CustomerNumber": 2, "Price": 93.83})
        Do TicketsArray.%Push({"TicketCode": "IBP359", "FlightNumber": 3, "AircraftNumber": 10, "SeatNumber": 5, "CustomerNumber": 9, "Price": 72.18})
        Do TicketsArray.%Push({"TicketCode": "PFW415", "FlightNumber": 4, "AircraftNumber": 1, "SeatNumber": 1, "CustomerNumber": 5, "Price": 121.02})
        Do TicketsArray.%Push({"TicketCode": "HMF431", "FlightNumber": 4, "AircraftNumber": 1, "SeatNumber": 3, "CustomerNumber": 1, "Price": 78.66})
        Do TicketsArray.%Push({"TicketCode": "EOM457", "FlightNumber": 4, "AircraftNumber": 1, "SeatNumber": 4, "CustomerNumber": 7, "Price": 60.51})
        Do TicketsArray.%Push({"TicketCode": "SGD512", "FlightNumber": 5, "AircraftNumber": 8, "SeatNumber": 1, "CustomerNumber": 2, "Price": 142.76})
        Do TicketsArray.%Push({"TicketCode": "LEJ535", "FlightNumber": 5, "AircraftNumber": 8, "SeatNumber": 3, "CustomerNumber": 5, "Price": 92.79})
        Do TicketsArray.%Push({"TicketCode": "WTX553", "FlightNumber": 5, "AircraftNumber": 8, "SeatNumber": 4, "CustomerNumber": 3, "Price": 71.38})
        Do TicketsArray.%Push({"TicketCode": "GOQ610", "FlightNumber": 6, "AircraftNumber": 7, "SeatNumber": 1, "CustomerNumber": 10, "Price": 160.18})
        Do TicketsArray.%Push({"TicketCode": "GGR638", "FlightNumber": 6, "AircraftNumber": 7, "SeatNumber": 3, "CustomerNumber": 8, "Price": 104.12})
        Do TicketsArray.%Push({"TicketCode": "WBP655", "FlightNumber": 6, "AircraftNumber": 7, "SeatNumber": 5, "CustomerNumber": 5, "Price": 80.09})
        Do TicketsArray.%Push({"TicketCode": "WEZ715", "FlightNumber": 7, "AircraftNumber": 3, "SeatNumber": 1, "CustomerNumber": 5, "Price": 121.54})
        Do TicketsArray.%Push({"TicketCode": "FHQ738", "FlightNumber": 7, "AircraftNumber": 3, "SeatNumber": 3, "CustomerNumber": 8, "Price": 79.0})
        Do TicketsArray.%Push({"TicketCode": "KZD756", "FlightNumber": 7, "AircraftNumber": 3, "SeatNumber": 5, "CustomerNumber": 6, "Price": 60.77})
        Do TicketsArray.%Push({"TicketCode": "IVV812", "FlightNumber": 8, "AircraftNumber": 4, "SeatNumber": 1, "CustomerNumber": 2, "Price": 159.82})
        Do TicketsArray.%Push({"TicketCode": "DEX838", "FlightNumber": 8, "AircraftNumber": 4, "SeatNumber": 3, "CustomerNumber": 8, "Price": 103.88})
        Do TicketsArray.%Push({"TicketCode": "GAL850", "FlightNumber": 8, "AircraftNumber": 4, "SeatNumber": 4, "CustomerNumber": 10, "Price": 79.91})
        Do TicketsArray.%Push({"TicketCode": "IJE910", "FlightNumber": 9, "AircraftNumber": 2, "SeatNumber": 1, "CustomerNumber": 10, "Price": 136.18})
        Do TicketsArray.%Push({"TicketCode": "QRS931", "FlightNumber": 9, "AircraftNumber": 2, "SeatNumber": 3, "CustomerNumber": 1, "Price": 88.52})
        Do TicketsArray.%Push({"TicketCode": "UJG957", "FlightNumber": 9, "AircraftNumber": 2, "SeatNumber": 5, "CustomerNumber": 7, "Price": 68.09})
        Do TicketsArray.%Push({"TicketCode": "DTE018", "FlightNumber": 10, "AircraftNumber": 4, "SeatNumber": 1, "CustomerNumber": 8, "Price": 167.04})
        Do TicketsArray.%Push({"TicketCode": "EQC031", "FlightNumber": 10, "AircraftNumber": 4, "SeatNumber": 3, "CustomerNumber": 1, "Price": 108.58})
        Do TicketsArray.%Push({"TicketCode": "YRA053", "FlightNumber": 10, "AircraftNumber": 4, "SeatNumber": 5, "CustomerNumber": 3, "Price": 83.52})

        For i=0:1:TicketsArray.%Size() -1 {
            Set TicketDetails = TicketsArray.%Get(i)
            Set NewTicket = ##class(EuropeAirports.Ticket).%New()
            Set NewTicket.TicketCode = TicketDetails.%Get("TicketCode")
            Set NewTicket.FlightNumber = TicketDetails.%Get("FlightNumber")
            Set NewTicket.AircraftNumber = TicketDetails.%Get("AircraftNumber")
            Set NewTicket.SeatNumber = TicketDetails.%Get("SeatNumber")
            Set NewTicket.CustomerNumber = TicketDetails.%Get("CustomerNumber")
            Set NewTicket.Price = TicketDetails.%Get("Price")

            Set sc = NewTicket.%Save()
            If $$$ISERR(sc) {
                Write "Error saving NewTicket: ", $System.Status.GetErrorText(sc),!
                Return sc
            }
        }

        Write "Tickets filled with data",!
    } Catch ex {
        Write "Error FillTickets: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod FillAllData() As %Status
{
    Set sc = $$$OK
    Try {
        Set sc = ..ClearData()
        Set sc = ..FillDiscounts()
        Set sc = ..FillCustomers()
        Set sc = ..FillAirports()
        Set sc = ..FillModels()
        Set sc = ..FillEmployees()
        Set sc = ..FillLicenses()
        Set sc = ..FillAircrafts()
        Set sc = ..FillFlights()
        Set sc = ..FillRolesInFlight()
        Set sc = ..FillSeats()
        Set sc = ..FillTickets()
        Write "FillAllData ended",!
    } Catch ex {
        Write "Error FillAllData: ", ex.DisplayString(),!
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

}
