module Main where

import Network.Wai.Handler.Warp
import qualified Database.PostgreSQL.Simple as Pg

import qualified API.EndPoint as EndPoint (app)
import Init (localPG)

main :: IO ()
main = do
    conn <- Pg.connect localPG :: IO Pg.Connection 
    -- case conn of
    --     Left err -> print err
    --     Right _ -> print "connection successful"
    -- print conn
    putStrLn "running on port 8080"
    run 8080 EndPoint.app