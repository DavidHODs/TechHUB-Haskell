module Init(localPG, envConnect, useEnv) where

import qualified Database.PostgreSQL.Simple as Pg
import GHC.Generics
import qualified System.Environment as Env
import Configuration.Dotenv (loadFile, defaultConfig)

localPG :: Pg.ConnectInfo
localPG = Pg.defaultConnectInfo
    {
        Pg.connectHost =  show $ envConnect "host" :: String,
        Pg.connectDatabase = show $ envConnect "database" :: String,
        Pg.connectUser =  show $ envConnect "pguser" :: String,
        Pg.connectPassword = show $ envConnect "pgpassword"  :: String
    } 

envConnect :: String -> IO String
envConnect = Env.getEnv

useEnv :: String
useEnv = show $ envConnect "databaseURL"

instance Show (IO String) where
    show = show 