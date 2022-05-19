module API.EndPoint (app) where

import qualified Model.Data as Data (User(..))
import qualified Controller.Logic as Logic (registerUser)

import qualified Data.Text as T
import Servant.API
import Servant

type API = "users" :> ReqBody '[JSON] Data.User :> Post '[JSON] T.Text

server :: Server API
server = return Logic.registerUser

api :: Proxy API 
api = Proxy

app :: Application
app = serve api server

