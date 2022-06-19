module Model.Data 
  (User(..), Response(..)) 
  where

import GHC.Generics
import Data.Aeson
import Data.Text
import Data.Time (ZonedTime, zonedTimeToUTC)
import Data.Default
import Data.Ord
import qualified Deriving.Aeson as DAE
import qualified Data.UUID as UUID
import qualified Relude.Unsafe as Unsafe

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
    via (GenericEntity '[TableName "users", PrimaryKey "id"] User)
instance ToJSON User
instance FromJSON User

instance Default ZonedTime where
  def = Unsafe.read "2019-08-31 05:14:37.537084021 UTC"

instance Eq ZonedTime where
  t1 == t2 = case comparing zonedTimeToUTC t1 t2 of
    EQ -> True
    _ -> False

data Response = Response
  {
    msg :: String,
    code :: Int,
    success :: Bool 
  } deriving (Generic, Show)
instance ToJSON Response


data Post = Post 
  {
    id :: UUID.UUID,
    author :: UUID.UUID,
    body :: String,
    tags :: UUID.UUID,
    likes :: Integer,
    dislikes :: Integer
  } deriving stock (Generic, Show, Eq)
  deriving anyclass (FromRow, ToRow)
  deriving
    (Entity)
    via (GenericEntity '[TableName "tech.posts", PrimaryKey "id"] Post)
instance ToJSON Post 
instance FromJSON Post