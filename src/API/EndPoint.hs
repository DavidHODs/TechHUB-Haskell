module API.EndPoint (app) where

import qualified Model.Data as Data (User(..), Response(..))
import qualified Controller.Logic as Logic (registerUser)

import qualified Data.Text as T
import Data.Maybe
import Servant.API
import Servant

type API = "users" :> ReqBody '[JSON] (Maybe Data.User) :> Post '[JSON] Data.Response

server :: Server API
server = Logic.registerUser 

api :: Proxy API 
api = Proxy

app :: Application
app = serve api server

