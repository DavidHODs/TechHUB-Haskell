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
import Init (envConnect)

main :: IO ()
main = do
  Dotenv.loadFile Dotenv.defaultConfig
  databaseURL <- envConnect "databaseURL"

  conn <- Pg.connectPostgreSQL $ encodeUtf8 (pack databaseURL)
  initializationRes <- Mg.runMigration conn Mg.defaultOptions Mg.MigrationInitialization
  print initializationRes

  migDir <- envConnect "migDir"
  migrationRes <- Mg.runMigration conn Mg.defaultOptions $ Mg.MigrationValidation (Mg.MigrationDirectory migDir)
  print migrationRes

  print "running on port 8080"
  run 8080 EndPoint.app