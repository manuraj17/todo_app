# TODO App

A simple TODO app.

# Starting the app
```
bundle exec rackup
```
App will be started at port `9292` by default

# Development
Running tests
```
bundle exec rspec
```

# API

Currently, user creation is not considered.
It is assumed that the user exists and all the `ToDos` are created for a user
who is identified via Authentication. Clearly for this, Authentication is also
not considered.

## Create TODO
```
POST /api/todos

{
  "description" : "Finish Assignment",
  "list_id" : 1
}
```

Response
```
{
  "message": "Todo created succesfully",
    "result": {
      "id": 1,
      "description": "Finish Assignment",
      "list": {
        "id": 1,
        "name": "default"
      }
    }
}
```  
## View a TODO
```
GET /api/todos/:id
```
Response  
```
{
    "id": 1,
    "description": "study physics",
    "due_date": null,
}
```

## Update TODO
```
PUT /api/todos/:id

{
  "description" : "updated todo"
}
```

Response
```
{
    "message": "Todo updated succesfully"
}
```

## Delete TODO
```
DELETE /api/todos

{
  "id": 1
}
```

Response
```
{
    "message": "Todo removed succesfully"
}
```

## Copy TODO to a new list
```
POST /api/todos/:id/copy

{
  "list_id": 3 // The target list id
}
```

Response
```
{
  "message": "Todo added succesfully"
}
```

## Move TODO to a new list
```
POST /api/todos/:id/move

{
  "old_list_id": 3,
  "new_list_id": 2
}
```

Response
```
{
  "message": "Todo moved succesfully"
}
```

## Create new list
```
POST /api/lists

{
  "name": "college"
}
```

Response
```
{
  "message": "List created succesfully",
    "result": {
      "id": 3,
      "name": "college",
      "todos": []
    }
}
```

## View all lists
```
GET /api/lists
```
Response
```
{
    "count": 2,
    "list": [
        {
            "id": 1,
            "name": "default",
            "todos": [
                1
            ]
        },
        {
            "id": 2,
            "name": "college",
            "todos": []
        }
    ]
}
```

## View a list
```
GET /api/list/:id
```

Response
```
{
  "list": {
    "id": 2,
      "name": "college",
      "todos": [1]
  }
}
```

## Add a reminder for a todo
```
POST /api/todos/:id/reminders

{
  todo_id: 1,
  time_at: "2020-03-17T15:57:15+05:30"
}
```  
Response
```
{
  "message": "Reminder created successfully",
  "result": {
      "id": 1,
      "todo_description": "study physics",
      "time_at": "2020-03-17T15:57:15+05:30"
  }
}
```