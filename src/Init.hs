module Init(localPG, envConnect, connect) where

import qualified Database.PostgreSQL.Simple as Pg
import GHC.Generics
import qualified System.Environment as Env
import Configuration.Dotenv (loadFile, defaultConfig)

localPG :: ConnectInfo
localPG = ConnectInfo
    {
        connectHost =  envConnect "host" :: IO String,
        connectDatabase = envConnect "database" :: IO String,
        connectUser =  envConnect "pguser" :: IO String,
        connectPassword = envConnect "pgpassword" :: IO String
    } 
-- instance Generic Pg.ConnectInfo

connect :: ConnectInfo -> IO Pg.Connection
connect = Pg.connectPostgreSQL . Pg.postgreSQLConnectionString

data ConnectInfo = ConnectInfo
    {
        connectHost :: IO String,
        connectDatabase :: IO String,
        connectUser :: IO String,
        connectPassword :: IO String
    } deriving (Generic)

envConnect :: String -> IO String
envConnect = Env.getEnv


-- instance Show (IO String) where
--     show :: IO String -> String
--     show = show