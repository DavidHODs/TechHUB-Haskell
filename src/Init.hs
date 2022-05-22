module Init(localPG) where

import qualified Database.PostgreSQL.Simple as Pg
import qualified System.Environment as Env

localPG :: Pg.ConnectInfo
localPG = Pg.defaultConnectInfo
    {
        Pg.connectHost = envConnect "host" :: String,
        Pg.connectDatabase = envConnect "hask" :: String,
        Pg.connectUser = envConnect "pguser" :: String,
        Pg.connectPassword = envConnect "pgpassword" :: String
    }

envConnect :: String -> String
envConnect param =
    show (Env.lookupEnv "host")

instance Show a where
    show :: a -> String
    show = show