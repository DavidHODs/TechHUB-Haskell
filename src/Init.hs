module Init(localPG) where

import qualified Database.PostgreSQL.Simple as Pg
import GHC.Generics
import qualified System.Environment as Env
import Configuration.Dotenv (loadFile, defaultConfig)

localPG :: Pg.ConnectInfo
localPG = Pg.defaultConnectInfo
    {
        Pg.connectHost =  useEnv "host" :: String,
        Pg.connectDatabase = useEnv "database" :: String,
        Pg.connectUser =  useEnv "pguser" :: String,
        Pg.connectPassword = useEnv "pgpassword"  :: String
    } 

envConnect :: String -> IO String
envConnect = Env.getEnv

useEnv :: String -> String
useEnv param = show $ envConnect param

instance Show (IO String) where
    show = show 