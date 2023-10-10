INSERT INTO
	TB_PROVINCIA (nomb_pro)
VALUES
	('San Juan'),
	('Mendoza');

SELECT * FROM TB_PROVINCIA

INSERT INTO
	TB_DISTRITO (idprovincia, nomb_dis)
VALUES
	(7, 'Rivadavia'),
	(7, 'Santa Lucia'),
	(8, 'Chacras de Coria'),
	(8, 'San Rafael');

SELECT * FROM TB_DISTRITO

INSERT INTO
	TB_PROFESION (nomb_pro)
VALUES
	('Profesor');

SELECT * FROM TB_PROFESION

INSERT INTO 
	TB_DOCENTE (apel_doc, nomb_doc, dire_doc, ntel_doc, ncel_doc, grad_doc, idprofesion)
VALUES
	('Estevez', 'Lola', 'San Lorenzo 1233 Oeste', '+1111111111111', '+2222222222222', 'UNSJ', 4);

SELECT * FROM TB_DOCENTE

INSERT INTO
	TB_CURSO (nomb_cur, cost_cur, dura_cur)
VALUES
	('Matemática', 123.45, 15); 

SELECT * FROM TB_CURSO

INSERT INTO 
	TB_ASIGNACION (fecha_asi, idcurso, iddocente)
VALUES
	(GETDATE(), 4, 4)

SELECT * FROM TB_ESTUDIANTE

INSERT INTO
	TB_MATRICULA(fecha_mat, idestudiante, idcurso)
VALUES
	(GETDATE(), 5, 4),
	(GETDATE(), 4, 4)






