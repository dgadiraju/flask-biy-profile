host="$1"
PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" << EOF

\c sms_db

CREATE TABLE instructors (
  instructor_id SERIAL PRIMARY KEY,
  instructor_first_name VARCHAR(30),
  instructor_last_name VARCHAR(30),
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_updated_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  course_name VARCHAR(30),
  instructor_id INT,
  start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_updated_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE courses
ADD CONSTRAINT courses_instructors_fk
FOREIGN KEY (instructor_id)
REFERENCES instructors (instructor_id);

EOF