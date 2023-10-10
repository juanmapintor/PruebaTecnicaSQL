CREATE PROCEDURE [Get_Estudiantes_Por_Provincia] AS
BEGIN
    SELECT
        prov.idprovincia AS [ID_Provincia],
        prov.nomb_pro AS [Nombre_Provincia],
        COUNT(1) AS [Cantidad_Estudiantes]
    FROM 
        TB_ESTUDIANTE est 
            JOIN TB_DISTRITO dist ON est.iddistrito = dist.iddistrito
            JOIN TB_PROVINCIA prov ON dist.idprovincia = prov.idprovincia
    GROUP BY
        prov.idprovincia,
        prov.nomb_pro
END

EXEC [Get_Estudiantes_Por_Provincia]

CREATE PROCEDURE [Get_Provincia_Mas_Estudiantes_Por_Curso] @idcurso INT
AS
BEGIN
    --Solucion 1 - Devuelve una sola provincia. <-- La considero la mas adecuada ya que la consigna especifica "LA" provincia (singular). 
    --PROS: Accede a cada tabla solo una vez. 
    --CONTRAS: Si para un curso en particular coincide la cantidad de alumnos de una provincia con otra, solo se muestra la que tiene el ID mas bajo.
    SELECT TOP 1
        curso.idcurso AS [ID_Curso],
        curso.nomb_cur AS [Nombre_Curso],
        prov.idprovincia AS [ID_Provincia],
        prov.nomb_pro AS [Nombre_Provincia],
        COUNT(1) AS [Cantidad_Alumnos]
    FROM
        TB_ESTUDIANTE est
            JOIN TB_MATRICULA mat ON est.idestudiante = mat.idestudiante
            JOIN TB_CURSO curso ON curso.idcurso = @idcurso AND mat.idcurso = curso.idcurso
            JOIN TB_DISTRITO dist ON est.iddistrito = dist.iddistrito
            JOIN TB_PROVINCIA prov ON dist.idprovincia = prov.idprovincia
    GROUP BY
        prov.idprovincia,
        prov.nomb_pro,
		curso.idcurso,
		curso.nomb_cur
	ORDER BY 
		[Cantidad_Alumnos] DESC,
        prov.idprovincia ASC

    --Solucion 2 - Devuelve una o mas provincias
    --PROS: En caso de coincidir la cantidad de estudiantes entre dos o mas provincias para un curso, muestra todas las provincias.
    --CONTRAS: Usa una tabla temporaria, por lo que su ejecución es mas pesada en memoria. 
    --En la tabla temporal guarda datos que no se utilizaran (provicias que no tienen el máximo número de alumnos). 
    --Accede a la tabla temporal 2 veces. 

	SELECT
        curso.idcurso AS [ID_Curso],
        curso.nomb_cur AS [Nombre_Curso],
        prov.idprovincia AS [ID_Provincia],
        prov.nomb_pro AS [Nombre_Provincia],
        COUNT(1) AS [Cantidad_Alumnos]
	INTO #CantidadEstudiantesPorProvincia
    FROM
        TB_ESTUDIANTE est
            JOIN TB_MATRICULA mat ON est.idestudiante = mat.idestudiante
            JOIN TB_CURSO curso ON curso.idcurso = @idcurso AND mat.idcurso = curso.idcurso
            JOIN TB_DISTRITO dist ON est.iddistrito = dist.iddistrito
            JOIN TB_PROVINCIA prov ON dist.idprovincia = prov.idprovincia
    GROUP BY
        prov.idprovincia,
        prov.nomb_pro,
		curso.idcurso,
		curso.nomb_cur
	ORDER BY 
		[Cantidad_Alumnos] DESC,
        prov.idprovincia ASC
	
	SELECT 
		*
	FROM #CantidadEstudiantesPorProvincia cant
	WHERE 
		Cantidad_Alumnos = (SELECT MAX(Cantidad_Alumnos) FROM #CantidadEstudiantesPorProvincia)

	DROP TABLE #CantidadEstudiantesPorProvincia
END

EXEC [Get_Provincia_Mas_Estudiantes_Por_Curso] 1 --EXEC [Get_Provincia_Mas_Estudiantes_Por_Curso] (idcurso)





