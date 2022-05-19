module Controller.Logic 
    (registerUser) 
    where 

import qualified Data.Text as T
import Servant

import qualified Model.Data as Data (User(..))

reg :: Data.User -> T.Text
reg u =
    Data.name u <> " , you succesfully registered. Your email is " <> Data.email u <> " and password " <> Data.password u   

registerUser :: Data.User -> Handler T.Text
registerUser u = 
    return (reg u)
