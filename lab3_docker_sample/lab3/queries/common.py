
from api.engine import DBConn
from models.user import User
from sqlalchemy import select


def list_users(department_id):
    # Щоб запросити дані з бази та отримати екземпляри певного класу в програмі, ми повинні
    # створити об'єкт класу Session.
    #
    # Цей клас реалізує сеанс – діалог з базою даних, що належить до поточної виконуваної
    # операції предметної області. Якщо програма звертається до кількох об'єктів при виконанні
    # однієї операції, то для всіх використовується той самий сеанс.
    #
    # У багатьох випадках сеанс пов'язаний із однією транзакцією.
    with DBConn.get_session() as session:
        users = session.execute(
            select(User).where(User.department_id == department_id))
        for user in users:
            print(user)
