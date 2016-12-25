from flask_bcrypt import generate_password_hash
from flask_login import UserMixin
from peewee import *

DATABASE = SqliteDatabase('tacocat.db')

class User(UserMixin, Model):
    email = CharField(unique=True)
    password = CharField(max_length=100)

    class Meta:
        database = DATABASE
        order_by = ('-email',)

    @classmethod
    def create_user(cls, email, password):
        try:
            with DATABASE.transaction():
                cls.create(
                    email=email,
                    password=generate_password_hash(password)
                )
        except IntegrityError:
            raise ValueError("User already exists")

class Taco(Model):
    protein = CharField()
    shell = CharField()
    cheese = BooleanField(default=False)
    extras = TextField(default='')
    user = ForeignKeyField(
        rel_model=User,
        related_name='taco'
    )

    class Meta:
        database = DATABASE
        order_by = ('-protein',)

def initialize():
    DATABASE.connect()
    DATABASE.create_tables([User, Taco], safe=True)
    DATABASE.close()