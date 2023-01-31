
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
    #dotenv.load_dotenv()
    DBConn()


@cli.command(help='Создать таблицы в БД')
def create_tables():
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
