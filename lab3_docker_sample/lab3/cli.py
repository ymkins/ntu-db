
import click
from queries import common
from scripts import database
from api.engine import DBConn
from models.base import myBase

# IMPORTANT: all models should be imported before the call to
#            myBase.metadata.create_all();
#            otherway no tables will be created
from models import *

@click.group()
def cli():
    # Щоб підключитися до бази, потрібно створити об'єкт engine. Зауважимо, що в цей момент програма
    # ще не підключилася до бази. Воно створило пул з'єднань, і коли бібліотеці SQLAlchemy знадобиться
    # виконати команду, вона запросить з'єднання з цього пулу. Якщо з'єднання ще не існує, воно буде
    # встановлено.
    DBConn()


@cli.command(help='Создать таблицы в БД')
def create_tables():
    # Щоб створити логічну структуру даних, визначену в метаданих, потрібно викликати метод
    # metadata.create_all(engine).
    myBase.metadata.create_all(DBConn.engine)


@cli.command(help='Удалить таблицы в БД')
def drop_tables():
    myBase.metadata.drop_all(DBConn.engine)


@cli.command(help='Выбрать пользователей по ID кафедры')
@click.option('--department-id', '-d', type=click.INT)
def list_users(department_id):
    common.list_users(department_id)


@cli.command(help='Заполнить БД тестовыми данными')
def fill_db():
    database.fill_db()


if __name__ == '__main__':
    cli()
