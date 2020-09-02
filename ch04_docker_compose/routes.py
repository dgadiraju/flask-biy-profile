from .app import app
from .models import Hw

# route - '/'
# controller for '/' - index()

@app.route('/')
def index():
    records = Hw.query.all()
    return_string = "{} {} from Database".format(records[0].s,records[1].s)
    return return_string