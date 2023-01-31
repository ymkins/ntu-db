# Lab-5 sample
#
# A basic bottle-app skeleton
#
# This is not a minimal skeleton. This shows you how to serve
# static content, a basic text only front page, and a templated page.

import bottle

app = application = bottle.Bottle()


@app.route('/static/<filename:path>')
def static(filename):
    """
    Serve static files
    """
    return bottle.static_file(filename, root='./static')


@app.route('/')
def show_index():
    """
    The front 'index' page
    """
    return 'Hello'


@app.route('/page/<page_name>')
def show_page(page_name):
    """
    Return a page that has been rendered using a template
    """
    return bottle.template('page', page_name=page_name)


# While you're testing, you don't want that slash unless the main page
# is being requested. Browsers seem to like adding that. It's not an issue
# when we get to deployment because uwsgi will take care of that for you.
class StripPathMiddleware(object):
    """
    Get that slash out of the request
    """
    def __init__(self, a):
        self.a = a

    def __call__(self, e, h):
        e['PATH_INFO'] = e['PATH_INFO'].rstrip('/')
        return self.a(e, h)


# Notice that bottle.run() only happens when you run app.py. It won't run when
# you launch it as an application with uwsgi. This chunk is also the only place
# that we call StripPathMiddleware. If you have no need for development, then you
# can remove the last two chunks of code.
if __name__ == '__main__':
    bottle.run(app=StripPathMiddleware(app),
               host='localhost',
               #host='0.0.0.0',
               port=8085,
               debug=True)
