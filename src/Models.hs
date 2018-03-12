{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module Models
  ( User(..)
  , Team(..)
  )
where

import Data.Aeson
import GHC.Generics
import Data.Time
import Database.SQLite.Simple

-- Incomplete models
data User = User
  { userId        :: Int
  , userTeamId :: Maybe Int
  , userName  :: String
  , phoneNumber :: String
  , email :: String
  } deriving (Eq, Show, Generic)

data Team = Team
  { teamId :: Int
  , teamName :: String
  } deriving (Eq, Show, Generic)

-- Instances

instance ToJSON User
instance ToJSON Team

instance ToRow User where
  toRow User{..} = toRow (userId, userTeamId, userName, phoneNumber, email)

instance FromRow User where
  fromRow = User <$> field <*> field <*> field <*> field <*> field

instance ToRow Team where
  toRow Team{..} = toRow (teamId, teamName)

instance FromRow Team where
  fromRow = Team <$> field <*> field
