{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE DeriveGeneric         #-}

module Lib
    ( startApp
    , app
    ) where

import Data.Maybe (fromJust)
import Models
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Database.SQLite.Simple
import qualified Data.List as DL
import qualified Queries as Q
import Control.Monad.Trans (liftIO)

cp :: Team
cp = Team 1 "team1"
df :: Team
df = Team 2 "team2"

teams :: [Team]
teams = [cp, df]

type UserAPI =  "users" :> Get '[JSON] [User]
type TeamAPI = "team" :> Capture "teamId" Int :> Get '[JSON] Team
type API = UserAPI :<|> TeamAPI

dbFile :: FilePath
dbFile = "test.db"

serveUsers :: Handler [User]
serveUsers = liftIO $ withConnection dbFile $ \conn ->
  query conn Q.getAllUsersStatement ()

serveTeam :: Int -> Handler Team
serveTeam _teamId =  return $ fromJust maybeTeam
  where maybeTeam = DL.find (\t -> (teamId t) == _teamId) teams

serveAPI :: Server API
serveAPI = serveUsers :<|> serveTeam

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api serveAPI

api :: Proxy API
api = Proxy
