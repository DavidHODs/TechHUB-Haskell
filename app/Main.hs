module Main where

import Network.Wai.Handler.Warp
import qualified Database.PostgreSQL.Simple as Pg
import Configuration.Dotenv (loadFile, defaultConfig)
import Data.Text.Encoding
import Data.Text
import Prelude

import qualified API.EndPoint as EndPoint (app)
import Init (localPG, envConnect, useEnv)

main :: IO ()
main = do
    loadFile defaultConfig
    conn <- Pg.connectPostgreSQL $ encodeUtf8 (pack useEnv)
    putStrLn "running on port 8080"
    run 8080 EndPoint.app