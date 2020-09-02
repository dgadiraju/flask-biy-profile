host="$1"
PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" << EOF

\c sms_db

INSERT INTO instructors (instructor_first_name, instructor_last_name)
VALUES ('Durga', 'Gadiraju');

INSERT INTO courses (course_name, instructor_id)
SELECT 'Python Workshop', instructor_id FROM instructors WHERE instructor_first_name = 'Durga';

COMMIT;
EOF