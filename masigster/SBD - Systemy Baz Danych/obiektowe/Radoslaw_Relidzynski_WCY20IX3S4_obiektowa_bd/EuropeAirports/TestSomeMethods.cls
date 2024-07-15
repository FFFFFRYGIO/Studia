Class EuropeAirports.TestSomeMethods Extends %RegisteredObject
{

ClassMethod TestDiscountUpdateDiscountPercentage() As %Status
{
    Set sc = $$$OK
    Try {
        // Pobiera Discount dla typu "rodzinna"
        Set tResult = ##class(%SQL.Statement).%New()
        Set sql = "SELECT ID, DiscountPercentage FROM EuropeAirports.Discount WHERE DiscountType = ?"
        Set sc = tResult.%Prepare(sql)

        Set rset = tResult.%Execute("rodzinna")

        // Wyświetla jego aktualną wartość
        If rset.%Next() {
            Set discountObjId = rset.%Get("ID")
            Set currentDiscount = rset.%Get("DiscountPercentage")
            Write "Current discount percentage for 'rodzinna': ", currentDiscount, !
            
            // Wywołuje metodę zmieniając jej wartość na 88
            Set discountObj = ##class(EuropeAirports.Discount).%OpenId(discountObjId)
            If discountObj '= $$$NULLOREF {
                Set newPercentage = 88
                Set updateStatus = discountObj.UpdateDiscountPercentage(newPercentage)
                If $$$ISERR(updateStatus) {
                    Write "Error updating discount percentage: ", ##class(%SYSTEM.Status).GetErrorText(updateStatus), !
                    Set sc = updateStatus
                } Else {
                    Write "Discount percentage updated successfully to ", newPercentage, !
                }
            } Else {
                Write "Discount object not found", !
                Set sc = $$$ERROR($$$GeneralError, "Discount object not found")
            }

            // Wyszukuje ponownie Discount dla typu "rodzinna"
            Set rset = tResult.%Execute("rodzinna")
            If rset.%Next() {
                Set newDiscount = rset.%Get("DiscountPercentage")
                
                // Wyświetla nową wartość
                Write "New discount percentage for 'rodzinna': ", newDiscount, !
            } Else {
                Write "No discount object found with type 'rodzinna' after update", !
                Set sc = $$$ERROR($$$GeneralError, "No discount object found with type 'rodzinna' after update")
            }
        } Else {
            Write "No discount object found with type 'rodzinna'", !
            Set sc = $$$ERROR($$$GeneralError, "No discount object found with type 'rodzinna'")
        }
    } Catch ex {
        Write "Error TestDiscountUpdateDiscountPercentage: ", ex.DisplayString(), !
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod TestCustomerGetDetails() As %Status
{
    Set sc = $$$OK
    Try {
        // Pobiera pierwszy dostępny Customer
        Set customerObj = ##class(EuropeAirports.Customer).%OpenId(1)
        If customerObj '= $$$NULLOREF {
            // Wyświetla szczegóły klienta
            Write "Customer details: ", customerObj.GetDetails(), !
        } Else {
            Write "Customer object not found", !
            Set sc = $$$ERROR($$$GeneralError, "Customer object not found")
        }
    } Catch ex {
        Write "Error TestCustomerGetDetails: ", ex.DisplayString(), !
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod TestCustomerBookAFlight() As %Status
{
    Set sc = $$$OK
    Try {
        Set CustomerObj = ##class(EuropeAirports.Customer).%OpenId(1)
        If CustomerObj '= $$$NULLOREF {
            Set SeatNumber = 12
            Set FlightNumber = 10
            Set Price = 150
            Set TicketCode = "ABC123"
            Set sc = CustomerObj.BookAFlight(SeatNumber, FlightNumber, Price, TicketCode)
            If $$$ISERR(sc) {
                Write "Error booking flight: ", ##class(%SYSTEM.Status).GetErrorText(sc), !
            } Else {
                Write "Flight booked successfully", !
            }
        } Else {
            Write "Customer object not found", !
            Set sc = $$$ERROR($$$GeneralError, "Customer object not found")
        }
    } Catch ex {
        Write "Error TestCustomerBookAFlight: ", ex.DisplayString(), !
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

ClassMethod RunTests() As %Status
{
    Set sc = $$$OK
    Try {
        Write "Starting tests for some methods in database", !
        Write "========================================", !
        Set sc = ..TestDiscountUpdateDiscountPercentage()
        Write "========================================", !
        Set sc = ..TestCustomerGetDetails()
        Write "========================================", !
        Set sc = ..TestCustomerBookAFlight()
        Write "========================================", !
        Write "RunTests ended", !
    } Catch ex {
        Write "Error RunTests: ", ex.DisplayString(), !
        Set sc = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit sc
}

}
