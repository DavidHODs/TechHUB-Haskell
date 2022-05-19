module Controller.Logic 
    (registerUser) 
    where 

import qualified Data.Text as T
import Servant

import qualified Model.Data as Data (User(..), Response(..))

reg :: Data.User -> Data.Response
reg u =
    Data.Response msg' code' success'
    
    where 
        msg' = Data.name u ++ " , you succesfully registered. Your email is " ++ Data.email u ++ " and password " ++ Data.password u :: String
        code' = 201 :: Int
        success' = True :: Bool

registerUser :: Data.User -> Handler Data.Response
registerUser u = 
    return (reg u)
