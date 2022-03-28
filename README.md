# book-store-haskell

## Tools
1. Sqlite3
2. Stack
3. Haskell

## Compile and run 
1. Install tools
2. Run script `run.sh`

## Api

Book:
```js
{
    "id": 123,
    "title": "title of the book",
    "cost" : 321.01
}
```

1. Post "/book"
   Body:
   ```js
    {
        "title": "title of the book",
        "cost" : 321.01
    }
   ```
   Response: status 200 or Error
2. Get "/book/:id" 
   id - id of the book
   Response: Book or Error (404)
3. Get "/books"
   Response: List of books
4. Delete "/book/:id" removeBook
   id - id of the book
   Response: status 200 or Error