{-# LANGUAGE OverloadedStrings #-}
module Queries
  (
  ) where

import Database.SQLite.Simple

userTableStatement :: Query
userTableStatement = "CREATE TABLE IF NOT EXISTS USERS(userId INT PRIMARY KEY, userTeamId INT NOT NULL, userName VARCHAR(100) NOT NULL, phoneNumber VARCHAR(20) NOT NULL, email VARCHAR(100) NOT NULL"

teamTableStatement :: Query
teamTableStatement = "CREATE TABLE IF NOT EXISTS TEAM(teamId INT PRIMARY KEY, teamName VARCHAR(50) NOT NULL" 

initDB :: FilePath -> IO ()
initDB db = withConnection db $ \conn -> do
  execute_ conn userTableStatement
  execute_ conn teamTableStatement
