from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def index():
    return list_courses()


@app.route('/containers')
def list_courses():

    courses = [
        {'course_name': 'Python - 101', 'course_description': 'Python for beginners'},
        {'course_name': 'Python - Web Development', 'course_description': 'Build Web Applications using Python Flask'}
    ]
    columns = courses[0].keys()
    return render_template('courses.html', data=courses, columns=columns)

