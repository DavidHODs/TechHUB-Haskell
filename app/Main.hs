module Main where

import Lib
import API.EndPoint(app)

main :: IO ()
main = run 8080 Endpoint.app
