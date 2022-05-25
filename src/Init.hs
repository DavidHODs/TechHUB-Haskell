module Init(localPG) where

import qualified Database.PostgreSQL.Simple as Pg
import GHC.Generics
import qualified System.Environment as Env
import Configuration.Dotenv (loadFile, defaultConfig)

localPG :: Pg.ConnectInfo
localPG = Pg.defaultConnectInfo
    {
        Pg.connectHost =  show . envConnect "host" :: String,
        Pg.connectDatabase = show . envConnect "database" :: String,
        Pg.connectUser =  show . envConnect "pguser" :: String,
        Pg.connectPassword = show . envConnect "pgpassword"  :: String
    } 
-- instance Generic Pg.ConnectInfo

-- connect :: ConnectInfo -> IO Pg.Connection
-- connect = Pg.connectPostgreSQL . Pg.postgreSQLConnectionString

-- data ConnectInfo = ConnectInfo
    -- {
    --     connectHost :: IO String,
    --     connectDatabase :: IO String,
    --     connectUser :: IO String,
    --     connectPassword :: IO String
    -- } deriving (Generic)

envConnect :: String -> IO String
envConnect = Env.getEnv


instance Show (IO String) where
    show = show