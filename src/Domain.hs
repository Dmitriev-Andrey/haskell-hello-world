{-# LANGUAGE OverloadedStrings #-}

module Domain where

import Control.Monad (mzero)
import Data.Aeson

data Book = Book
  { id :: Int,
    title :: String,
    cost :: Double
  }
  deriving (Show)

instance FromJSON Book where
  parseJSON (Object v) =
    Book
      <$> v .:? "id" .!= 0
      <*> v .: "title"
      <*> v .: "cost"
  parseJSON _ = mzero

instance ToJSON Book where
  toJSON (Book id title cost) =
    object
      [ "id" .= id,
        "title" .= title,
        "cost" .= cost
      ]