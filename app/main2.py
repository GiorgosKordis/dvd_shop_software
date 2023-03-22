# from random import randrange
# from typing import Optional
# from fastapi.params import Body
from fastapi import  FastAPI,Response, status, HTTPException
from pydantic import BaseModel
import psycopg2
from psycopg2.extras import RealDictCursor
import time
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()


origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class DVD(BaseModel):
    title: str
    genre: str
    num_copies: int


while True:
    try:
        conn = psycopg2.connect(host='localhost',database='dvdshop',user='postgres' ,password ='postword1', cursor_factory=RealDictCursor)
        cursor = conn.cursor()
        print("Connected to database succesfully!")
        break
    except Exception as error:
        print("Connecting to database failed!")
        print("Error: ", error)
        time.sleep(2)



@app.get("/")
def root():

    return {"message": "Hello World of DVDs!"}


@app.get("/dvds")
def get_posts():
    cursor.execute("""SELECT * FROM dvds """)
    dvds = cursor.fetchall()
    return{"data":dvds}


@app.post('/dvds',status_code=status.HTTP_201_CREATED)
def add_dvd(dvd: DVD):
    cursor.execute("""INSERT INTO dvds (title, genre, num_copies) VALUES(%s, %s, %s) RETURNING * """,
                   (dvd.title, dvd.genre, dvd.num_copies))
    new_dvd = cursor.fetchone()

    conn.commit()

    return{'data': new_dvd}

@app.get("/dvds/{id}")
def get_dvd(id: int):
    cursor.execute("""SELECT * FROM dvds WHERE id = %s """, (str(id),))
    
    dvd = cursor.fetchone()

    if not dvd:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"dvd with id {id} was not found")
    return {"dvd detail": dvd}

@app.delete("/dvds/{id}",status_code=status.HTTP_204_NO_CONTENT)
def delete_dvd(id: int):
    cursor.execute("""DELETE FROM dvds WHERE id = %s RETURNING *""",(str(id),))
    deleted_dvd = cursor.fetchone()
    conn.commit()
    if deleted_dvd == None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"dvd with id {id} does not exist")
    
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@app.put("/dvds/{id}")
def update_post(id: int, dvd: DVD):
    cursor.execute("""UPDATE dvds SET title = %s, genre = %s, num_copies = %s WHERE id = %s RETURNING *""", (dvd.title, dvd.genre, dvd.num_copies, str(id)))
    updated_dvd = cursor.fetchone()
    conn.commit()
    if updated_dvd == None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"dvd with id {id} does not exist")
    return {'message': updated_dvd}