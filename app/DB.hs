{-# LANGUAGE OverloadedStrings #-}

module DB where

import Control.Monad.Trans (lift)
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Domain

instance FromRow Book where
  fromRow =
    Book <$> field
      <*> field
      <*> field

addBook :: Book -> IO ()
addBook (Book _ title cost) =
  withConn $
    \conn -> execute conn "insert into book (title, cost) values (?,?);" (title, cost)

getBookByid :: Int -> IO (Maybe Book)
getBookByid bookId =
  withConn $
    \conn -> do
      books <- query conn "select * from book where id = (?);" (Only bookId) :: IO [Book]
      return $ firstOrNothing books

firstOrNothing :: [Book] -> Maybe Book
firstOrNothing [] = Nothing
firstOrNothing (x : _) = Just x

getBooks :: IO [Book]
getBooks = do
  withConn $
    \conn -> query_ conn "select * from book;" :: IO [Book]

deleteBook :: Int -> IO ()
deleteBook bookId =
  withConn $
    \conn -> execute conn "delete from book where id = ?;" (Only bookId)

withConn :: (Connection -> IO a) -> IO a
withConn action = do
  conn <- open "store.db"
  res <- action conn
  close conn
  return res