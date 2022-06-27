module Controller.Logic 
  (registerUser) 
  where 

import qualified Data.Text as T
import Servant
import Data.Maybe
import qualified Data.Pool as Pool
import qualified Relude as R
import Control.Monad.Reader.Class

import Database.PostgreSQL.Simple (Only (Only))
import qualified Database.PostgreSQL.Simple.Internal as Internal
import Database.PostgreSQL.Simple.SqlQQ (sql)
import qualified Database.PostgreSQL.Entity as PgE (insert)
import qualified Database.PostgreSQL.Transact as PgT
import Database.PostgreSQL.Entity.DBT (withPool)

import qualified Model.Data as Data (User(..), Response(..))

newtype Config = Config 
  {
    pool :: Pool.Pool Internal.Connection
  }

-- instance MonadReader

reg :: Maybe Data.User -> IO Data.Response
reg u = 
  case u of 
    Nothing -> do
      print "required fields cannot be blank"
      return $ Data.Response "required fields cannot be blank" 500 False

    Just u -> do
      -- pool <- asks pool
      -- _ <- R.liftIO $ do
      --   withPool pool $ do 
      --     _ <- insertUser u
      --     R.pass
      print $ msg' ++ ", " ++ "200 Success"
      return $ Data.Response msg' code' success'
      
      where 
        msg' = Data.name u ++ " , you succesfully registered. Your email is " ++ Data.email u ++ " and password " ++ Data.password u :: String
        code' = 201 :: Int
        success' = True :: Bool


registerUser :: Maybe Data.User -> Handler (IO Data.Response)
registerUser u = 
  return (reg u)

insertUser :: Data.User -> PgT.DBT IO ()
insertUser = PgE.insert @Data.User