module ContactList.Commands exposing (fetchContactList)

import Commands exposing (contactsApiUrl)
import ContactList.Decoder as Decoder
import ContactList.Messages exposing (Msg(FetchContactList))
import Http


fetchContactList : Int -> String -> Cmd Msg
fetchContactList page search =
    let
        apiUrl =
            contactsApiUrl
                ++ "?search="
                ++ search
                ++ "&page="
                ++ (toString page)
    in
        Decoder.decoder
            |> Http.get apiUrl
            |> Http.send FetchContactList
