CREATE TABLE `cursos` (
  `curso_id` int NOT NULL AUTO_INCREMENT,
  `curso_estudiante_id` int NOT NULL,
  `curso_profesor_id` int NOT NULL,
  `curso_nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`curso_id`),
  UNIQUE KEY `curso_id_UNIQUE` (`curso_id`),
  KEY `curso_estudiante_id_idx` (`curso_estudiante_id`),
  KEY `curso_profesor_id_idx` (`curso_profesor_id`),
  CONSTRAINT `curso_estudiante_id` FOREIGN KEY (`curso_estudiante_id`) REFERENCES `estudiantes` (`estudiante_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `curso_profesor_id` FOREIGN KEY (`curso_profesor_id`) REFERENCES `profesores` (`profesor_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `calificaciones` (
  `calificacion_id` int NOT NULL AUTO_INCREMENT,
  `calificacion_estudiante_id` int NOT NULL,
  `calificacion_profesor_id` int NOT NULL,
  `calificacion_curso_id` int NOT NULL,
  `calificacion` int NOT NULL,
  UNIQUE KEY `calificacion_id_UNIQUE` (`calificacion_id`),
  KEY `calificacion_estudiante_id_idx` (`calificacion_estudiante_id`) /*!80000 INVISIBLE */,
  KEY `calificacion_profesor_id_idx` (`calificacion_profesor_id`),
  KEY `calificacion_curso_id_idx` (`calificacion_curso_id`),
  CONSTRAINT `calificacion_curso_id` FOREIGN KEY (`calificacion_curso_id`) REFERENCES `cursos` (`curso_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `calificacion_estudiante_id` FOREIGN KEY (`calificacion_estudiante_id`) REFERENCES `estudiantes` (`estudiante_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `calificacion_profesor_id` FOREIGN KEY (`calificacion_profesor_id`) REFERENCES `profesores` (`profesor_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `estudiantes` (
  `estudiante_id` int NOT NULL AUTO_INCREMENT,
  `estudiante_nombre` varchar(45) DEFAULT NULL,
  `estudiante_email` varchar(45) NOT NULL,
  PRIMARY KEY (`estudiante_id`),
  UNIQUE KEY `estudiantes_id_UNIQUE` (`estudiante_id`),
  UNIQUE KEY `estudiante_email_UNIQUE` (`estudiante_email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `profesores` (
  `profesor_id` int NOT NULL AUTO_INCREMENT,
  `profesor_nombre` varchar(45) NOT NULL,
  UNIQUE KEY `profesores_id_UNIQUE` (`profesor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-------------------------------------------------------------------

USE javier_santos_proyecto_universidad;

INSERT INTO estudiantes(estudiante_nombre, estudiante_email)
VALUES ("Pedro", 'pedro@gmail.com');

INSERT INTO estudiantes(estudiante_nombre, estudiante_email)
VALUES ("Laura", 'laura@gmail.com');

INSERT INTO estudiantes(estudiante_nombre, estudiante_email)
VALUES ("Cristina", 'cristina@gmail.com');

INSERT INTO estudiantes(estudiante_nombre, estudiante_email)
VALUES ("Antonio", 'antonio@gmail.com');

INSERT INTO estudiantes(estudiante_nombre, estudiante_email)
VALUES ("Ignacio", 'ignacio@gmail.com');

SELECT *
FROM estudiantes;

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('1', '1', 'tecnologia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('2', '1', 'tecnologia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ( '3', '3', 'economia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('4', '3', 'economia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('5', '3', 'economia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('1', '3', 'economia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('5', '3', 'geografia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('4', '3', 'geografia');

INSERT INTO cursos(curso_estudiante_id, curso_profesor_id, curso_nombre)
VALUES ('1', '3', 'geografia');

SELECT *
FROM cursos;

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('1', '1', '1','8');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('2', '1', '2','4');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('3', '3', '3','10');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('4', '3', '4','8');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('5', '3', '5','6');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('1', '3', '6','4');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('5', '3', '7','6');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('4', '3', '8','6');

INSERT INTO calificaciones(calificacion_estudiante_id, calificacion_profesor_id , calificacion_curso_id , calificacion)
VALUES ('1', '3', '9','9');

SELECT *
FROM calificaciones;

INSERT INTO profesores(profesor_nombre)
VALUES ('Emiliano');

INSERT INTO profesores(profesor_nombre)
VALUES ( 'Petry');

SELECT *
FROM profesores;

---------------------------------------------------------

SELECT calificacion_profesor_id, AVG(calificacion)
FROM calificaciones
GROUP BY calificacion_profesor_id;

SELECT calificacion_estudiante_id, MAX(calificacion)
FROM calificaciones
GROUP BY calificacion_estudiante_id;

SELECT  curso_nombre, COUNT(curso_estudiante_id) AS "alumnos"
FROM cursos
GROUP BY curso_nombre;

SELECT curso_nombre, AVG(calificacion) AS "calificacion"
FROM cursos 
JOIN calificaciones 
ON cursos.curso_id = calificaciones.calificacion_curso_id
GROUP BY cursos.curso_nombre;

WITH comun AS (
	SELECT estudiantes.estudiante_nombre, profesores.profesor_nombre,
    COUNT(DISTINCT cursos.curso_id) cursos
	FROM calificaciones
	JOIN estudiantes ON calificaciones.calificacion_estudiante_id = estudiantes.estudiante_id
	JOIN cursos ON calificaciones.calificacion_curso_id = cursos.curso_id
	JOIN profesores ON cursos.curso_profesor_id = profesores.profesor_id
	GROUP BY estudiantes.estudiante_nombre, profesores.profesor_nombre
)
SELECT * FROM comun
WHERE comun.cursos = (
	SELECT MAX(cursos) FROM comun
);


