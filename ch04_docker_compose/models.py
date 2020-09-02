from .app import db

class Hw(db.Model):
    __tablename__ = 'hw'
    i = db.Column(db.Integer,primary_key=True)
    s = db.Column(db.String(64))