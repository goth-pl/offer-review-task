# Universal Backend: Offer Review

## List of available endpoints

### Authentication

#### 1. Authenticate

```
POST /api/v1/auth

Params
{
    "email": string,
    "password": string
}

Response (status 200)
{
    "token": string
}

Error (status 400)
{
    "error": "invalid_credentials"
}
```

### Offers

#### 1. List all offers

```
GET /api/v1/offers
Authorization: Bearer <TOKEN>

Response (status 200)
{
    offers: [
        {
            "id": integer,
            "status": enum(created accepted rejected),
            "created_at": string,
            "products": [
                {
                    "quantity": integer,
                    "price": decimal(10,2),
                    "parameters": ProductParameters (depending on product type - see below for more details)
                }
            ],
            "salesman": {
                "email": string
            },
            "client": {
                "email": string
            }
        }
    ]
}

Error (status 401)
{
    "error": "invalid_token / missing_token"
}
```

#### 2. Show an offer

```
GET /api/v1/offers/:id
Authorization: Bearer <TOKEN>

Response (status 200)
{
    offer: {
       "id": integer,
       "status": enum(created accepted rejected),
       "created_at": string,
       "products": [
           {
               "quantity": integer,
               "price": decimal(10,2),
               "parameters": ProductParameters (depending on product type - see below for more details)
           }
       ],
       "salesman": {
           "email": string
       },
       "client": {
           "email": string
       }
   }
}

Error (status 401)
{
    "error": "invalid_token / missing_token"
}

Error (status 403)
{
    "error": "unauthorized"
}
```

#### 3. Create an offer

```
POST /api/v1/offers
Authorization: Bearer <TOKEN>

Params
{
    "client_id": integer,
    "products": [
        {
            "type": enum(Product::MailerBox Product::PolyMailer),
            "quantity": integer,
            "parameters": ProductParameters (depending on product type - see below for more details)
        }
    ]
}

Response (status 201)
{
    offer: {
       "id": integer,
       "status": enum(created accepted rejected),
       "created_at": string,
       "products": [
           {
               "quantity": integer,
               "price": decimal(10,2),
               "parameters": ProductParameters (depending on product type - see below for more details)
           }
       ],
       "salesman": {
           "email": string
       },
       "client": {
           "email": string
       }
   }
}

Error (status 400)
{
    "errors": a list of validation errors
}

Error (status 401)
{
    "error": "invalid_token / missing_token"
}

Error (status 403)
{
    "error": "unauthorized"
}
```

#### 4. Accept an offer

```
PATCH /api/v1/offers/:id/accept
Authorization: Bearer <TOKEN>

Response (status 200)
{
    offer: {
       "id": integer,
       "status": enum(created accepted rejected),
       "created_at": string,
       "products": [
           {
               "quantity": integer,
               "price": decimal(10,2),
               "parameters": ProductParameters (depending on product type - see below for more details)
           }
       ],
       "salesman": {
           "email": string
       },
       "client": {
           "email": string
       }
   }
}

Error (status 401)
{
    "error": "invalid_token / missing_token"
}

Error (status 403)
{
    "error": "unauthorized"
}
```

#### 5. Reject an offer

```
PATCH /api/v1/offers/:id/reject
Authorization: Bearer <TOKEN>

Response (status 200)
{
    offer: {
       "id": integer,
       "status": enum(created accepted rejected),
       "created_at": string,
       "products": [
           {
               "quantity": integer,
               "price": decimal(10,2),
               "parameters": ProductParameters (depending on product type - see below for more details)
           }
       ],
       "salesman": {
           "email": string
       },
       "client": {
           "email": string
       }
   }
}

Error (status 401)
{
    "error": "invalid_token / missing_token"
}

Error (status 403)
{
    "error": "unauthorized"
}
```

## Product Parameters

### 1. Mailer Box Parameters

```
{
    "width": integer,
    "height": integer,
    "length": integer
}
```

### 1. Poly Mailer Parameters

```
{
    "width": integer,
    "height": integer,
    "material": enum(black transparent)
}
```