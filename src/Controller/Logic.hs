module Controller.Logic 
  (registerUser) 
  where 

import qualified Data.Text as T
import Servant
import Data.Maybe
import Database.PostgreSQL.Simple (Only (Only))
import Database.PostgreSQL.Simple.SqlQQ (sql)
import Database.PostgreSQL.Transact (DBT)

import qualified Model.Data as Data (User(..), Response(..))

reg :: Maybe Data.User -> Data.Response
reg u = 
  case u of 
    Nothing -> do
      print $ Data.Response (error "required fields cannot be blank") 500 False
      Data.Response (error "required fields cannot be blank") 500 False

    Just u -> do 
      print $ Data.Response msg' code' success'
      insertUser $ fromJust u :: DBT IO ()
      Data.Response msg' code' success'
      
      where 
        msg' = Data.name (fromJust u) ++ " , you succesfully registered. Your email is " ++ Data.email (fromJust u) ++ " and password " ++ Data.password (fromJust u) :: String
        code' = 201 :: Int
        success' = True :: Bool

registerUser :: Maybe Data.User -> Handler Data.Response
registerUser u = 
  return (reg u)

insertUser :: Maybe Data.User -> DBT IO ()
insertUser user = insert @Data.User $ fromJust user