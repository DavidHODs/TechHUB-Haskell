module Init(localPG, envConnect) where

import qualified Database.PostgreSQL.Simple as Pg
import qualified System.Environment as Env
import Configuration.Dotenv (loadFile, defaultConfig)

localPG :: Pg.ConnectInfo
localPG = Pg.defaultConnectInfo
    {
        Pg.connectHost =  envConnect "host" :: String,
        Pg.connectDatabase = envConnect "database" :: String,
        Pg.connectUser =  envConnect "pguser" :: String,
        Pg.connectPassword = envConnect "pgpassword" :: String
    }

envConnect :: String -> String
envConnect param =
    show (Env.getEnv param)

instance Show (IO String) where
    show :: IO String -> String
    show = show