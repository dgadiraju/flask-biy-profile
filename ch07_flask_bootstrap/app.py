from flask import Flask, render_template
from flask_bootstrap import Bootstrap

app = Flask(__name__)
Bootstrap(app)


@app.route('/')
def index():
    return list_courses()


@app.route('/containers')
def list_courses():

    courses = [
        {'Name': 'Python - 101', 'Description': 'Python for beginners'},
        {'Name': 'Python - Web Development', 'Description': 'Build Web Applications using Python Flask'}
    ]
    columns = courses[0].keys()
    return render_template('courses.html', data=courses, columns=columns)

