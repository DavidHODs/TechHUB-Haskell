module Model.Data 
  (User(..), Response(..)) 
  where

import GHC.Generics
import Data.Aeson
import Data.Text
import Data.Time
import qualified Data.UUID as UUID
import Database.PostgreSQL.Entity.Types
import Database.PostgreSQL.Simple.FromField (FromField (..))
import Database.PostgreSQL.Simple.FromRow (FromRow (..))
import Database.PostgreSQL.Simple.ToField (ToField (..))
import Database.PostgreSQL.Simple.ToRow (ToRow (..))
import Database.PostgreSQL.Transact (DBT)

data User = User 
  {
    id :: UUID.UUID,
    name :: String,
    email :: String,
    password :: String,
    createdAt :: ZonedTime,
    updatedAt :: ZonedTime
  } deriving stock (Generic, Show, Eq)
  deriving anyclass (FromRow, ToRow)
  deriving 
    (Entity) 
    via (GenericEntity '[Schema "tech", TableName "users", PrimaryKey "id", FieldModifiers '[CamelToSnake]] User)
instance ToJSON User
instance FromJSON User

data Response = Response
  {
    msg :: String,
    code :: Int,
    success :: Bool 
  } deriving (Generic, Show)
instance ToJSON Response
