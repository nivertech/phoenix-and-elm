module Contact.Request exposing (fetchContact, contactSpec)

import GraphQL.Request.Builder
    exposing
        ( Document
        , NonNull
        , ObjectType
        , Request
        , Query
        , ValueSpec
        , extract
        , field
        , int
        , object
        , queryDocument
        , request
        , string
        , with
        )
import GraphQL.Request.Builder.Arg as Arg
import GraphQL.Request.Builder.Variable as Var
import Model exposing (Contact)


{-|
   query($contactID: ID) {
     contact(id: $contactID) {
       firstName
       lastName
       gender
       birthDate
       location
       phoneNumber
       email
       headline
       picture
     }
   }
-}
fetchContact : Int -> Request Query Contact
fetchContact id =
    let
        contactID =
            Arg.variable (Var.required "contactID" .contactID Var.int)

        contactField =
            field
                "contact"
                [ ( "id", contactID ) ]
                contactSpec

        params =
            { contactID = id }
    in
        contactField
            |> extract
            |> queryDocument
            |> request params


contactSpec : ValueSpec NonNull ObjectType Contact vars
contactSpec =
    Contact
        |> object
        |> with (field "id" [] int)
        |> with (field "firstName" [] string)
        |> with (field "lastName" [] string)
        |> with (field "gender" [] int)
        |> with (field "birthDate" [] string)
        |> with (field "location" [] string)
        |> with (field "phoneNumber" [] string)
        |> with (field "email" [] string)
        |> with (field "headline" [] string)
        |> with (field "picture" [] string)