module Model.Data 
  (User(..), Response(..)) 
  where

import GHC.Generics
import Data.Aeson
import Data.Text

data User = User 
  {
    name :: String,
    email :: String,
    password :: String,
    createdAt :: UTCTime,
    updatedAt :: UTCTime
  } deriving(Generic, Show, Eq)
instance ToJSON User
instance FromJSON User

data Response = Response
  {
    msg :: String,
    code :: Int,
    success :: Bool 
  } deriving (Generic, Show)
instance ToJSON Response
instance FromJSON Response
