module Main where

import Network.Wai.Handler.Warp
import qualified Database.PostgreSQL.Simple as Pg
import qualified Database.PostgreSQL.Simple.Options as Op
import qualified Database.PostgreSQL.Simple.Migration as Mg
import qualified Configuration.Dotenv as Dotenv (loadFile, defaultConfig)
import Data.Text.Encoding
import Data.Text
import Prelude

import qualified API.EndPoint as EndPoint (app)
import Model.Secret (secret)

main :: IO ()
main = do
    Dotenv.loadFile Dotenv.defaultConfig
    -- secret is enclosed in a file ignored by git - it's a quack way to connect with postgres as I've not resolved working around the constraint of environment data returning IO String data type
    conn <- Pg.connectPostgreSQL $ encodeUtf8 (pack secret)
    Mg.runMigration conn Mg.defaultOptions $ Mg.MigrationValidation (Mg.MigrationDirectory "Database/Postgres")
    putStrLn "running on port 8080"
    run 8080 EndPoint.app
