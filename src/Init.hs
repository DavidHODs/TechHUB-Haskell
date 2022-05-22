module Init(localPG) where

import qualified Database.PostgreSQL.Simple as Pg
import qualified System.Environment as Env

localPG :: Pg.ConnectInfo
localPG = Pg.defaultConnectInfo
    {
        Pg.connectHost = envConnect "localhost" :: String,
        Pg.connectDatabase = envConnect "hask" :: String,
        Pg.connectUser = envConnect "pguser" :: String,
        Pg.connectPassword = envConnect "pgpassword" :: String
    }

envConnect :: String -> String 
envConnect param = show (Env.getEnv "param")

instance Show a where
    show :: IO String -> String
    show = show


    -- instance Default ZonedTime where
    --     def = Unsafe.read "2019-08-31 05:14:37.537084021 UTC"