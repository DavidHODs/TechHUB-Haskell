module Main where

import Network.Wai.Handler.Warp

import qualified API.EndPoint as EndPoint (app)

main :: IO ()
main = do
    putStrLn "running on port 8080"
    run 8080 EndPoint.app