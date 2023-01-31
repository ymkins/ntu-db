
import sqlalchemy as sa
from sqlalchemy import orm
from .base import myBase


class Department(myBase):
    __tablename__ = 'department'

    id = sa.Column(sa.Integer, primary_key=True)
    name = sa.Column(sa.String(256))

    has_users = orm.relationship('User', back_populates="belongs_to_department")
