module Model.Data 
    (User(..)) 
    where

import GHC.Generics
import Data.Aeson
import qualified Data.Text as T

data User = User 
    {
        name :: T.Text,
        email :: T.Text,
        password :: T.Text
    } deriving(Generic, Show, Eq)
instance ToJSON User
instance FromJSON User

data Response = Response
    {
        msg :: T.Text,
        code :: Int,
        success :: Bool 
    } deriving (Generic, Show)
instance ToJSON Response
instance FromJSON Response