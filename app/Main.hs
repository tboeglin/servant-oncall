{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import System.Remote.Monitoring
import qualified Data.ByteString as BS

ekgHostname :: BS.ByteString
ekgHostname = "localhost"

ekgPort :: Int
ekgPort = 8000


main :: IO ()
main = do
  putStrLn $ "Starting EKG on " ++ (show ekgHostname) ++ ":" ++ (show ekgPort)
  _ <- forkServer ekgHostname ekgPort
  putStrLn "Starting oncall"
  startApp
