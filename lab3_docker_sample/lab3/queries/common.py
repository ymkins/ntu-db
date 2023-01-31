
from api.engine import DBConn
from models.user import User
from sqlalchemy import select


def list_users(department_id):
    with DBConn.get_session() as session:
        users = session.execute(
            select(User).where(User.department_id == department_id))
        for user in users:
            print(user)
