{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.Trans (liftIO)
import DB
import Domain
import Lib
import Network.HTTP.Types.Status
import Web.Scotty

main :: IO ()
main = do
  scotty 4000 $ do
    post "/book" Main.addBook

    get "/book/:id" getById

    get "/books" getAllBooks

    delete "/book/:id" removeBook

addBook :: ActionM ()
addBook = do
  book <- jsonData
  liftIO $ DB.addBook book
  status ok200
  

getById :: ActionM ()
getById = do
  id <- param "id"
  book <- liftIO $ DB.getBookByid id
  case book of
    Just book -> json book
    Nothing -> status notFound404

getAllBooks :: ActionM ()
getAllBooks = do
  books <- liftIO getBooks
  json books

removeBook :: ActionM ()
removeBook = do
  id <- param "id"
  liftIO $ DB.deleteBook id
  status ok200